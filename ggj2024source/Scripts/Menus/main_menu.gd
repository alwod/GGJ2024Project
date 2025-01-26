extends CenterContainer

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/comic_strip.tscn")