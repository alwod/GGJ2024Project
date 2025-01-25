extends RigidBody2D
class_name Duck

@export var move_speed := 1500
@export var jump_potential := 100
@export var jump_time := 1000

var last_jump_time := 0

func _ready():
	set_contact_monitor(true)

func _process(_delta):
	var force := Vector2(0, 0)

	if Input.is_action_pressed("duck_move_left"):
		force.x -= move_speed
	elif Input.is_action_pressed("duck_move_right"):
		force.x += move_speed

	var time_since_last_jump := Time.get_ticks_msec() - last_jump_time

	if Input.is_action_pressed("duck_jump") and time_since_last_jump > (jump_time * 1.5):
		last_jump_time = Time.get_ticks_msec()

	if time_since_last_jump < (jump_time / 2):
		apply_impulse(Vector2(0, -jump_potential))

	if time_since_last_jump > (jump_time / 2) && time_since_last_jump < jump_time:
		apply_impulse(Vector2(0, jump_potential))

	apply_force(force)
