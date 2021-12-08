extends "res://addons/action_behavior_tree/lib/group_node.gd"

func tick(tick: Tick):
	for child in get_children():
		if child is BNode:
			var status = child.run_tick(tick);
			if status != Status.FAILED:
				return status
	return Status.FAILED
