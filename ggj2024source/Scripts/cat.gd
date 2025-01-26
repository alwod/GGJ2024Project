extends Node2D

@export var spawn_distance_from_player = 5000
@export var paw_speed = 5000

@export var duck: Node2D
@export var fish: Node2D

var player_position
var starting_pos
var can_move = false
var move_up = false
var cat_area_active = false

var fish_is_in = false
var duck_is_in = false

@onready var cat_paw: StaticBody2D = $CatPaw
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	starting_pos = cat_paw.global_position
	reset_paw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if can_move:
		# If the paw is above the player, move down towards it's level.
		if cat_paw.global_position.y <= player_position.y - 10 && !move_up:
			cat_paw.global_position.y += paw_speed * delta
		# Once the paw has reached the player's y level, move back up to its starting position.
		else:
			move_up = true
			cat_paw.global_position.y -= paw_speed * delta
			# Stops the paw from moving once it's reached its starting position.
			if cat_paw.global_position.y <= starting_pos.y:
				reset_paw()
				#if !fish_is_in && !duck_is_in:
				move_paw()

func reset_paw():
	cat_paw.visible = false
	can_move = false
	move_up = false
	cat_paw.global_position = starting_pos

func move_paw():
	var i = randi_range(0, 1)
	if fish_is_in && !duck_is_in:
		player_position = fish.global_position
	elif duck_is_in && !fish_is_in:
		player_position = duck.global_position
	else:
		if i == 0:
			player_position = fish.global_position
		else:
			player_position = duck.global_position
		$Meow.play()
	
	cat_paw.global_position = player_position
	cat_paw.global_position.y -= spawn_distance_from_player
	cat_paw.visible = true
	can_move = true
	

func _on_cat_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("fish") || body.is_in_group("duck"):
		if body.is_in_group("fish"):
			fish_is_in = true
		elif body.is_in_group("duck"):
			duck_is_in = true
		move_paw()


func _on_cat_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("fish") || body.is_in_group("duck"):
		if body.is_in_group("fish"):
			fish_is_in = false
		else:
			duck_is_in = false
		move_up = true
		reset_paw()
