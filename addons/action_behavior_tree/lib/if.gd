extends "res://addons/action_behavior_tree/lib/group_node.gd"

var running_node = null;

func _init():
	children_count = 1

func tick(tick: Tick):
	if running_node != null:
		var result = running_node.run_tick(tick)
		if result != Status.RUNNING:
			running_node = null;
		return result;
	else:
		if test(tick):
			var child = find_first()
			if child != null:
				var result = child.run_tick(tick)
				if result == Status.RUNNING:
					running_node = child;
				return result;
		return Status.FAILED

# Override
func test(tick: Tick):
	return false;
	
func reset():
	.reset()
	running_node = null
