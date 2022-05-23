extends "res://addons/action_behavior_tree/lib/action.gd"

var speed: Vector2

func action(tick):
	if tick.target.hit_state != null:
		var hit_state = tick.target.hit_state
		tick.target.hit_state = null
		var from = tick.target.hit_from
		tick.target.rotation = from.rotation + PI 
		tick.target.hit_from = null
		speed = hit_state.speed
		tick.target.get_sprite().modulate = Color(1,0,0,1)
		yield(wait(10 * hit_state.power), "completed")
		tick.target.get_sprite().modulate = Color(1,1,1,1)
		tick.target.speed = Vector2()
	return Status.FAILED

func running(tick, frames):
	tick.target.speed = speed * 0.8
