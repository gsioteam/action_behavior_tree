extends "res://addons/action_behavior_tree/lib/group_node.gd"

class TaskQueue:
	var children: Array
	var index = 0
	var inited = false
	
	func tick(tick):
		if index >= children.size():
			return BNode.Status.FAILED
		
		var child:BNode = children[index]
		var result = child.run_tick(tick)
		if result != BNode.Status.RUNNING:
			index += 1
			if index < children.size():
				result = BNode.Status.RUNNING
		return result

var task_queue: TaskQueue = TaskQueue.new()

func tick(tick: Tick):
	if not task_queue.inited:
		reset()
	
	var result = task_queue.tick(tick)
	if result != Status.RUNNING:
		task_queue.inited = false
	return result

func _reset_queue():
	task_queue.children.clear()
	for child in get_children():
		if child is BNode:
			task_queue.children.append(child)
	task_queue.index = 0
	task_queue.inited = true

func reset():
	.reset()
	_reset_queue()
