extends Area2D

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
		if position.y == rise_to_level:
			should_move = false
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("duck"):
		is_plug_open = true
	
	if(body.is_in_group("fish")) && is_plug_open:
		get_tree().quit()
