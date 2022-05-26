extends "res://addons/action_behavior_tree/lib/group_node.gd"
#
# The behavior of this node is same as the target node.
export (NodePath) var target_path

var _target

func get_target() -> BNode:
	if _target == null:
		_target = get_node(target_path)
	return _target

func reset():
	.reset()
	get_target().reset()
	_target = null

func tick(tick: Tick):
	return get_target().run_tick(tick)

