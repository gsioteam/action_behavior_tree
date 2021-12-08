extends "res://addons/action_behavior_tree/lib/if.gd"


func test(tick):
	return tick.target.hit_state != null


