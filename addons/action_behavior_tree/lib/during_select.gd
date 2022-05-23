extends "res://addons/action_behavior_tree/lib/group_node.gd"

var _priority:BNode = null
var _selected:BNode = null

func tick(tick):
	if _selected != null:
		var result = _selected.run_tick(tick);
		if result != Status.RUNNING:
			_selected = null
		return result
	else:
		var priority_node = _priority
		_priority = null
		if priority_node is BNode:
			var result = priority_node.run_tick(tick)
			if result == Status.RUNNING:
				_selected = priority_node
			if result != Status.FAILED:
				return result
		for child in get_children():
			if child is BNode and child != priority_node:
				var result = child.run_tick(tick)
				if result == Status.RUNNING:
					_selected = child
				if result != Status.FAILED:
					return result
	return Status.FAILED


func reset():
	.reset()
	_selected = null

func _request_focus(child: BNode):
	if _selected != child and child.get_parent() == self:
		reset()
		_priority = child
		
