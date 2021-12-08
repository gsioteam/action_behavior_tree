extends "res://addons/action_behavior_tree/lib/group_node.gd"

export var duration: int = 5
var _runningCount: float = 0
var _running = false

func _init():
	children_count = 1

func tick(tick: Tick):
	if _runningCount > 0:
		_runningCount -= Engine.time_scale
		find_first().run_tick(tick)
		return Status.RUNNING
	else:
		if _running:
			_running = false
			find_first().run_tick(tick)
			return Status.SUCCEED
		else:
			_running = true
			_runningCount = duration
			find_first().run_tick(tick)
			return Status.RUNNING
