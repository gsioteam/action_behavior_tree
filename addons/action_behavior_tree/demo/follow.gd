extends "res://addons/action_behavior_tree/lib/action.gd"

export(float) var distence = 24
const speed = 50

var _old_speed
var _run_count = 0

func tick(tick):
	if _old_speed == null:
		var target = tick.global_context["focus"]
		var direct:Vector2 = tick.target.position - target.position
		var tar_pos:Vector2 = target.position + direct.normalized() * distence
		var off = tar_pos - tick.target.position 
		if abs(off.x) > abs(off.y):
			if off.x > 0:
				tick.target.rotation = deg2rad(90)
				_old_speed = Vector2(speed, 0)
				_run_count = 0
			else:
				tick.target.rotation = deg2rad(270)
				_old_speed = Vector2(-speed, 0)
				_run_count = 0
		else:
			if off.y > 0:
				tick.target.rotation = deg2rad(180)
				_old_speed = Vector2(0, speed)
				_run_count = 0
			else:
				tick.target.rotation = deg2rad(0)
				_old_speed = Vector2(0, -speed)
				_run_count = 0
	if _old_speed != null:
		tick.target.move_and_slide(_old_speed)
		_run_count += 1
		if _run_count > 10:
			_old_speed = null
	return Status.RUNNING
