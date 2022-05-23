#
# A state machine
#

extends "res://addons/action_behavior_tree/lib/group_node.gd"

export (int) var index setget set_index, get_index

func tick(tick: Tick):
	var child = get_child(_index)
	if child is BNode:
		return child.run_tick(tick);
	return Status.FAILED

func _request_focus(child: BNode):
	if child.get_parent() == self:
		var idx = get_children().find(child)
		if idx != _index:
			reset()
			_index = idx

func debug_data():
	return {
		"index": _index
	}

var _index = 0

func set_index(v):
	if _index != v:
		var subnode = get_child(_index)
		_index = v
		subnode.reset()

func get_index():
	return _index
