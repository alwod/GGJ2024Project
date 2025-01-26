extends Node2D

func _on_skip_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")