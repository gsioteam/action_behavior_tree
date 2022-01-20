extends KinematicBody2D

const BNode = preload("res://addons/action_behavior_tree/lib/b_node.gd")
const HitState = preload("res://addons/action_behavior_tree/demo/hit_state.gd")

var tick = null
export var speed = Vector2()
var hit_state: HitState
var hit_from

# Called when the node enters the scene tree for the first time.
func _ready():
	tick = BNode.Tick.new(self)
	set_meta("type", "Character")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$behav.run_tick(tick)
	tick.end_frame()
	if speed != Vector2():
		move_and_slide(Vector2(speed.x, -speed.y).rotated(rotation))

func play_anim(name):
	$anim.play(name)
	yield($anim, "animation_finished")

func attack(state: HitState, hit_bodis: Array):
	var hti = false
	if $weapon/area.visible:
		var bodis = $weapon/area.get_overlapping_bodies()
		for body in bodis:
			if body.get_meta("type") == "Character" and not hit_bodis.has(body):
				hit_bodis.append(body)
				body.hit(state, self)
				hti = true
	return hti

func hit(state: HitState, from):
	$behav.reset()
	hit_state = state
	hit_from = from

func get_sprite():
	return $sprite
