extends Node

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/comic_strip.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value/1000)
	print("game volume set %s" % value)
