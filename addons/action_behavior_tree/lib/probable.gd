extends "res://addons/action_behavior_tree/lib/if.gd"

export var probability: float = 0.2
var last_randon = 0

func test(tick):
	last_randon = randf()
	return last_randon < probability

func debug_data():
	return {
		"random": last_randon
	}
