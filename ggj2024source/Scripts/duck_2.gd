extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -350.0

@export var push_force := 100
@export var jump_time := 1000
var last_jump_time := 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("duck_jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	var time_since_last_jump := Time.get_ticks_msec() - last_jump_time

	if Input.is_action_pressed("duck_jump") and time_since_last_jump > (jump_time * 1.5):
		last_jump_time = Time.get_ticks_msec()

	if time_since_last_jump < (jump_time / 2):
		velocity.y = JUMP_VELOCITY
		$Squeak.play()
		
	if Input.is_action_just_pressed("duck_move_left"):
		$DuckMove.play()
			
	if Input.is_action_just_pressed("duck_move_right"):
		$DuckMove.play()


	if time_since_last_jump > (jump_time / 2) && time_since_last_jump < jump_time:
		#apply_impulse(Vector2(0, jump_potential))
		pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("duck_move_left", "duck_move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var should_flip := false

	if direction < 0:
		should_flip = true
	elif direction > 0:
		should_flip = false

	if should_flip:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			if (-c.get_normal().y < 0.1 ):
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
		elif  c.get_collider() is CharacterBody2D:
			c.get_collider().velocity += -c.get_normal() * push_force
