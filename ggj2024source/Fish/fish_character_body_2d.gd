extends CharacterBody2D

@export var speed = 400  # move speed in pixels/sec
@export var rotation_speed = 5  # turning speed in radians/sec
@export var surface_y_pos = -77
@export var acceleration = 1500
@export var friction = 600


func _physics_process(delta):
	var move_input = Input.get_axis("fish_move_down", "fish_move_up")
	var rotation_direction = Input.get_axis("fish_move_left", "fish_move_right")
	velocity = transform.x * move_input * speed
	rotation += rotation_direction * rotation_speed * delta
	
	if move_input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (move_input * acceleration * delta)
		velocity = velocity.limit_length(speed)
	
	#print(global_position.y)
	
	if global_position.y < surface_y_pos:
		global_position.y = surface_y_pos
	
	move_and_slide()
