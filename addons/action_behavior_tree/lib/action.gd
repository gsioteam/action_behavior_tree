extends "res://addons/action_behavior_tree/lib/group_node.gd"

var running_child:BNode = null

class RunningTask:
	var result = null
	
	func _init(task: GDScriptFunctionState):
		var ret = yield(task, "completed")
		while ret is GDScriptFunctionState:
			ret = yield(ret, "completed")
		result = ret
	
	func tick():
		if result == null:
			return BNode.Status.RUNNING
		else:
			return result

var process: RunningTask = null

func _init():
	children_count = 1

func tick(tick):
	if running_child != null:
		var result = running_child.run_tick(tick)
		if result != Status.RUNNING:
			running_child = null
		return result
	if process == null:
		return _run_action(tick);
	else:
		var status = process.tick()
		if status == Status.RUNNING:
			running(tick)
		else:
			process = null
		if can_cancel(tick):
			var child = find_first()
			if child != null:
				var result = child.run_tick(tick)
				match result:
					Status.RUNNING:
						running_child = child
						process = null
					Status.SUCCEED:
						process = null
		return status

func _run_action(tick: Tick):
	var result = action(tick);
	if result is GDScriptFunctionState:
		process = RunningTask.new(result)
		return process.tick()
	return result;

func action(tick: Tick):
	return Status.SUCCEED

func can_cancel(tick: Tick):
	return false

func running(tick: Tick):
	pass

func process_child(child, tick):
	while true:
		var result = child.run_tick(tick);
		if result == Status.RUNNING:
			yield()
		else:
			return result

func reset():
	.reset()
	running_child = null
	process = null
