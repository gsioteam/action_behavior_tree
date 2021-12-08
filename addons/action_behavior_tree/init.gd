tool
extends EditorPlugin


func _enter_tree():
	add_custom_type(
		"Select",
		"Node",
		preload("res://addons/action_behavior_tree/lib/select.gd"),
		preload("res://addons/action_behavior_tree/lib/select.png")
	)
	add_custom_type(
		"Sequence",
		"Node",
		preload("res://addons/action_behavior_tree/lib/sequence.gd"),
		preload("res://addons/action_behavior_tree/lib/sequence.png")
	)
	add_custom_type(
		"If",
		"Node",
		preload("res://addons/action_behavior_tree/lib/if.gd"),
		preload("res://addons/action_behavior_tree/lib/if.png")
	)
	add_custom_type(
		"DuringSelect",
		"Node",
		preload("res://addons/action_behavior_tree/lib/during_select.gd"),
		preload("res://addons/action_behavior_tree/lib/during_select.png")
	)
	add_custom_type(
		"Action",
		"Node",
		preload("res://addons/action_behavior_tree/lib/action.gd"),
		preload("res://addons/action_behavior_tree/lib/action.png")
	)
	add_custom_type(
		"Parallel",
		"Node",
		preload("res://addons/action_behavior_tree/lib/parallel.gd"),
		preload("res://addons/action_behavior_tree/lib/parallel.png")
	)
	add_custom_type(
		"Period",
		"Node",
		preload("res://addons/action_behavior_tree/lib/period.gd"),
		preload("res://addons/action_behavior_tree/lib/period.png")
	)
	add_custom_type(
		"Probable",
		"Node",
		preload("res://addons/action_behavior_tree/lib/probable.gd"),
		preload("res://addons/action_behavior_tree/lib/if.png")
	)
	add_custom_type(
		"Queue",
		"Node",
		preload("res://addons/action_behavior_tree/lib/queue.gd"),
		preload("res://addons/action_behavior_tree/lib/queue.png")
	)
	pass


func _exit_tree():
	remove_custom_type("Select")
	remove_custom_type("Sequence")
	remove_custom_type("If")
	remove_custom_type("DuringSelect")
	remove_custom_type("Action")
	remove_custom_type("Parallel")
	remove_custom_type("Period")
	remove_custom_type("Probable")
	remove_custom_type("Queue")
	pass