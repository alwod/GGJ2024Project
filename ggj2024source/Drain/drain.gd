extends Node2D

var is_plug_open = false
var should_move = true
@export var rising_speed = 20
@export var rise_to_level = 4680

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_plug_open = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_plug_open && should_move:
		position.y -= rising_speed
		if position.y <= rise_to_level:
			should_move = false

func _on_plug_body_entered(body: Node2D) -> void:
	if body.is_in_group("fish") && is_plug_open:
		# Should replace with a change to main menu scene once it's implemented
		get_tree().change_scene_to_file("res://Scenes/outro_cutscene.tscn")


func _on_chain_body_entered(body: Node2D) -> void:
	if body.is_in_group("duck"):
		is_plug_open = true
		$Draining.play()
