extends "res://addons/action_behavior_tree/lib/action.gd"

export var animation: String
var bodis: Array
export(Resource) var hit_state

func action(tick):
	bodis = []
	yield(tick.target.play_anim(animation), "completed")
	return Status.SUCCEED

func can_cancel(tick, frames):
	return bodis != null && bodis.size() > 0

func running(tick, frames):
	if hit_state != null:
		tick.target.attack(hit_state, bodis)
