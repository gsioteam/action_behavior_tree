extends "res://addons/action_behavior_tree/lib/if.gd"

export(NodePath) var scanner
var _scanner

func get_scanner() -> Area2D:
	if _scanner == null:
		_scanner = get_node(scanner)
	return _scanner

func test(tick):
	var bodis = get_scanner().get_overlapping_bodies()
	for body in bodis:
		if body.name == "char":
			tick.global_context["focus"] = body
			return true
	return false

