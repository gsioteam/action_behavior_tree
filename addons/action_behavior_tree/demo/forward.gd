extends "res://addons/action_behavior_tree/lib/action.gd"


export var angle: int = 0
export var speed: float = 50

func action(tick):
	var rad = deg2rad(angle)
	tick.target.rotation = rad
	var sp = Vector2(0, -speed * Engine.time_scale).rotated(rad);
	tick.target.move_and_slide(sp)
	return Status.SUCCEED

