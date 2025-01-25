extends Node2D

@export var paw_scene: PackedScene
@export var spawn_distance_from_player = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_paw(player_position):
	var paw = paw_scene.instantiate()
	paw.global_position = Vector2(0, 0)
	paw.global_position.y -= spawn_distance_from_player
	add_child(paw)

func _on_cat_area_body_entered(body: Node2D) -> void:
	spawn_paw(body.global_position)
