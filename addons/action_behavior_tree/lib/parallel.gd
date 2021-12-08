extends "res://addons/action_behavior_tree/lib/group_node.gd"

func tick(tick: Tick):
	var ret = Status.FAILED;
	for child in get_children():
		if child is BNode:
			var result = child.run_tick(tick)
			if result == Status.RUNNING:
				ret = Status.RUNNING
			elif result == Status.SUCCEED && ret != Status.RUNNING:
				ret = Status.SUCCEED
	return ret
