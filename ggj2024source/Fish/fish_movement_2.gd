extends CharacterBody2D

@export var max_speed = 400
@export var acceleration = 1500
@export var friction = 600

var water_surface_y_level = 0
@export var force_out_of_water = 5

var input = Vector2.ZERO

func get_input():
	input = Input.get_vector("fish_move_left", "fish_move_right", "fish_move_up", "fish_move_down")
	return input.normalized()

func flip_fish():
	if Input.is_action_just_pressed("fish_move_right"):
		$AnimatedSprite2D.flip_h = true;
	if Input.is_action_just_pressed("fish_move_left"):
		$AnimatedSprite2D.flip_h = false;
		

func player_movement(delta):
	input = get_input()
	flip_fish()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()


func _physics_process(delta: float) -> void:
	player_movement(delta)
	
	if global_position.y < water_surface_y_level:
		global_position.y += force_out_of_water;
