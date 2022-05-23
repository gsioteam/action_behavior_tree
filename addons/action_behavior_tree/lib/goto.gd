extends "res://addons/action_behavior_tree/lib/group_node.gd"

export (NodePath) var target_path
var target

func _ready():
	target = get_node(target_path)

func tick(tick: Tick):
	if target is BNode:
		target.require_focus()
		return Status.SUCCEED
	return Status.SUCCEED
