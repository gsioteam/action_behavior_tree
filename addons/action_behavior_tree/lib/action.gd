extends "res://addons/action_behavior_tree/lib/group_node.gd"

const Running = preload('res://addons/action_behavior_tree/lib/running.gd')

var running_child:BNode = null

class RunningTask:
	var result = null
	var frame = 0
	var reset = false
	
	func _init(task: GDScriptFunctionState):
		var ret = yield(task, "completed")
		while ret is GDScriptFunctionState:
			ret = yield(ret, "completed")
		result = ret
	
	func tick():
		frame += 1
		if result == null:
			return BNode.Status.RUNNING
		else:
			return result

var process: RunningTask = null
var _running: Running

func _ready():
	for child in get_children():
		if child is Running:
			_running = child
			break

func _init():
	children_count = 0

func tick(tick):
	if running_child != null:
		var result = running_child.run_tick(tick)
		if result != Status.RUNNING:
			running_child = null
		return result
	if process == null:
		var status = _run_action(tick);
		if status != Status.FAILED and _running != null:
			_running.tick(tick)
		return status
	else:
		var frame = process.frame
		var status = process.tick()
		if status == Status.RUNNING:
			running(tick, frame)
			if _running != null:
				_running.tick(tick)
		else:
			process = null
			stop_running()
		if can_cancel(tick, frame):
			for child in get_children():
				if child is BNode:
					var result = child.run_tick(tick)
					match result:
						Status.RUNNING:
							enter_subaction(tick, child)
							running_child = child
							status = result
							process = null
							stop_running()
						Status.SUCCEED:
							enter_subaction(tick, child)
							status = result
							process = null
							stop_running()
		return status

func _run_action(tick: Tick):
	var result = action(tick);
	if result is GDScriptFunctionState:
		process = RunningTask.new(result)
		return process.tick()
	return result;

# Override
func action(tick: Tick):
	return Status.FAILED

func can_cancel(tick: Tick, frame: int):
	return false

func running(tick: Tick, frame: int):
	pass

func stop_running():
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
	if _running != null:
		_running.reset()
	running_child = null
	if ticking:
		if process != null:
			process.reset = true
	else:
		process = null
		stop_running()

func post_tick(tick):
	if process != null and process.reset:
		process = null
		stop_running()

func enter_subaction(tick: Tick, subaction):
	pass
