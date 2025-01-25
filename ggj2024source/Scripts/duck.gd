extends RigidBody2D
class_name Duck

@export var move_speed = 400
@export var jump_potential = 10

func _ready():
	set_contact_monitor(true)

func _process(_delta):
	var force = Vector2()

	if Input.is_action_pressed("duck_move_left"):
		force.x -= move_speed
	elif Input.is_action_pressed("duck_move_right"):
		force.x += move_speed
	elif Input.is_action_pressed("duck_jump"):
		apply_central_impulse(Vector2(0, -jump_potential))

	# if force.x != 0 || force.y != 0:
	apply_force(force)
