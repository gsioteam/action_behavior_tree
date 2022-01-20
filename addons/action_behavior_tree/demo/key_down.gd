extends "res://addons/action_behavior_tree/lib/if.gd"

export var action: String;

func test(tick):
	return Input.is_action_pressed(action)

func debug_data():
	return {
		"action": action
	}
