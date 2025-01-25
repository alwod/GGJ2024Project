extends CharacterBody2D

@export var speed = 400  # move speed in pixels/sec
@export var rotation_speed = 5  # turning speed in radians/sec

func _physics_process(delta):
	var move_input = Input.get_axis("fish_move_down", "fish_move_up")
	var rotation_direction = Input.get_axis("fish_move_left", "fish_move_right")
	velocity = transform.x * move_input * speed
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
