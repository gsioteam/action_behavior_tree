
extends Node
class_name BNode, "res://addons/action_behavior_tree/lib/b_node.png"

enum Status {
	RUNNING = 0,
	SUCCEED = 1,
	FAILED = -1,
}

class FrameListener:
	var count: int = 1
	
	signal completed
	
	func _init(count):
		self.count = count
	
	func tick():
		count -= 1
		if count <= 0:
			emit_signal("completed")
			return true
		return false

var last_status = -1
var frame = 0
var frame_listeners = []

var _last_frame = false

var ticking = false

export (bool) var enable = true

class Tick:
	var target
	var frame_context: Dictionary
	var global_context: Dictionary
	
	func _init(target):
		frame_context = {}
		global_context = {}
		self.target = target
		
	func end_frame():
		frame_context.clear()

func has_new():
	var active = _last_frame
	_last_frame = false
	return active

func tick(tick: Tick):
	return Status.SUCCEED

func post_tick(tick: Tick):
	pass

func run_tick(tick: Tick):
	if not enable:
		return Status.FAILED
	ticking = true
	var need_remove = []
	for listener in frame_listeners:
		if listener.tick():
			need_remove.append(listener)
	for listener in need_remove:
		frame_listeners.erase(listener)
	var new_status = self.tick(tick)
	if new_status == null:
		new_status = Status.FAILED
	if last_status != new_status:
		last_status = new_status
		if new_status != Status.RUNNING:
			frame = 0
	if new_status == Status.RUNNING:
		frame += 1
	post_tick(tick)
	_last_frame = true
	ticking = false
	return last_status

func reset():
	frame = 0
	frame_listeners.clear()

func wait(frame: int) -> FrameListener:
	var listener = FrameListener.new(frame)
	frame_listeners.append(listener)
	return listener

func get_root_node() -> BNode:
	return null

func get_parent_node() -> BNode:
	return null

func debug_data() -> Dictionary:
	return {}

func _request_focus(child: BNode):
	pass

func require_focus():
	pass

