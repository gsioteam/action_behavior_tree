extends "res://addons/action_behavior_tree/lib/group_node.gd"

var _selected:BNode = null;

func tick(tick):
	if _selected != null:
		var result = _selected.run_tick(tick);
		if result != Status.RUNNING:
			_selected = null
		return result
	else:
		for child in get_children():
			if child is BNode:
				var result = child.run_tick(tick)
				if result == Status.RUNNING:
					_selected = child
				if result != Status.FAILED:
					return result
	return Status.FAILED

func reset():
	.reset()
	_selected = null
