extends Node2D

@export var spawn_distance_from_player = 5000
@export var paw_size_scale = 0.25
@export var paw_speed = 5000

var player_position
var starting_pos
var can_move = false
var move_up = false
var cat_area_active = false

@onready var cat_paw: StaticBody2D = $CatPaw
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_paw()
	starting_pos = cat_paw.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if can_move:
		# If the paw is above the player, move down towards it's level.
		if cat_paw.global_position.y <= player_position.y && !move_up:
			cat_paw.global_position.y += paw_speed * delta
		# Once the paw has reached the player's y level, move back up to its starting position.
		else:
			move_up = true
			cat_paw.global_position.y -= paw_speed * delta
			# Stops the paw from moving once it's reached its starting position.
			if cat_paw.global_position.y <= starting_pos.y:
				reset_paw()
				move_paw()

func reset_paw():
	cat_paw.visible = false
	can_move = false
	move_up = false

func move_paw():
	cat_paw.global_position = player_position
	cat_paw.global_position.y -= spawn_distance_from_player
	cat_paw.visible = true
	can_move = true
	

func _on_cat_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("fish") || body.is_in_group("duck"):
		player_position = body.global_position
		move_paw()


func _on_cat_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("fish") || body.is_in_group("duck"):
		pass
