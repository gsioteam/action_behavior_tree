extends "res://addons/action_behavior_tree/lib/action.gd"

func action(tick):
	yield(get_tree().create_timer(1), "timeout")
	return Status.SUCCEED
