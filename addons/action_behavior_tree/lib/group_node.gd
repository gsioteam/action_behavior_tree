tool
extends "res://addons/action_behavior_tree/lib/b_node.gd"

var children_count = 0;

func _ready():
	if children_count > 0 && get_child_count() != children_count:
		push_warning(str("Children count(", children_count, ") is not match."));

func find_first() -> BNode:
	for child in get_children():
		if child is BNode:
			return child
	return null

func reset():
	.reset()
	for child in get_children():
		if child is BNode:
			child.reset()

func get_root_node() -> BNode:
	var parent = get_parent_node()
	if parent == null:
		return self
	return parent.get_root_node()
	
func get_parent_node() -> BNode:
	var parent = get_parent()
	if parent is BNode:
		return parent
	return null

func require_focus():
	var child = self
	var parent = get_parent_node()
	while parent != null:
		parent._request_focus(child)
		child = parent
		parent = parent.get_parent_node()

