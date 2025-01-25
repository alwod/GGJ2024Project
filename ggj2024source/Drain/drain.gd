extends Area2D

var drain_is_plugged = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("duck"):
		print("Success!")
		drain_is_plugged = false
	
	if body.is_in_group("fish") && drain_is_plugged == false:
		get_tree().quit()
