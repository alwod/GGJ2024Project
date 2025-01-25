extends Area2D

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handles fish movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("fish_move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("fish_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("fish_move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("fish_move_right"):
		velocity.x += 1
		
	# Handle movement direction. Will also animate sprite in the future
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		pass
		
	position += velocity * delta
	# Prevents duck from moving out of bounds, will need to replace later.
	position = position.clamp(Vector2.ZERO, screen_size)
