extends "res://addons/action_behavior_tree/lib/group_node.gd"

enum Type {
	RUNNING_FIRST,
	SUCCED_FIRST,
	FAILED_FIRST,
	LAST_RESULT
}

export(Type) var type = Type.RUNNING_FIRST

func tick(tick: Tick):
	var ret = null
	for child in get_children():
		if child is BNode:
			var result = child.run_tick(tick)
			match type:
				Type.RUNNING_FIRST:
					if ret != Status.RUNNING:
						ret = result
				Type.SUCCED_FIRST:
					if ret != Status.SUCCEED:
						ret = result
				Type.FAILED_FIRST:
					if ret != Status.FAILED:
						ret = result
				Type.LAST_RESULT:
					ret = result
	return ret
