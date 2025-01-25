extends CharacterBody2D
class_name FloatablePlayer2D

@export var mass := 1.0
@export var fluid_damp := 4.0
@export var move_speed := 200.0
@export var rotate_speed := 10.0
@onready var fluid_interactor := FluidInteractor2D.new()


func _ready():
	for owner_id in get_shape_owners():
		var collision = shape_owner_get_owner(owner_id)
		if collision is CollisionShape2D:
			fluid_interactor.add_collision_shape(collision)


func _physics_process(delta: float) -> void:
	fluid_interactor.process(global_transform, mass)
	
	if not fluid_interactor.float_force.is_zero_approx():
		# Bouyancy
		velocity += fluid_interactor.float_force * delta
		# Damping
		velocity += -velocity * fluid_damp * delta

	if is_on_floor():
		velocity.x = 0.0

	# Gravity
	velocity += Vector2(0.0, 3980.0) * delta
	
	var move_direction := 0.0
	if Input.is_action_pressed("ui_left"):
		move_direction = -1.0
	if Input.is_action_pressed("ui_right"):
		move_direction = 1.0
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -500
		
	#var move_direction = Input.get_axis("fish_move_down", "fish_move_up")
	#var rotation_direction = Input.get_axis("fish_move_left", "fish_move_right")
	#velocity = transform.x * move_direction * move_speed
	#rotation += rotation_direction * rotate_speed * delta
		
	#var move_input = Input.get_axis("fish_move_down", "fish_move_up")
	#var rotation_direction = Input.get_axis("fish_move_left", "fish_move_right")
	#velocity = transform.x * move_input * move_speed
	#rotation += rotation_direction * rotate_speed * delta
	
	if abs(move_direction) > 0:
		velocity.x = move_direction * move_speed

	move_and_slide()


func fluid_area_enter(area: FluidArea2D) -> void:
	fluid_interactor.fluid_area_enter(area)


func fluid_area_exit(area: FluidArea2D) -> void:
	fluid_interactor.fluid_area_exit(area)
