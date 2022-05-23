extends Node


func tick(tick):
	for child in get_children():
		if child is BNode:
			child.run_tick(tick)

func reset():
	for child in get_children():
		if child is BNode:
			child.reset()
