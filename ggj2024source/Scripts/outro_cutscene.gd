extends Node2D

var dialogues := [
					 {
						 "character": "Bub",
						 "value": "Wow...I can't believe we really made it"
					 },
					 {
						 "character": "Bub",
						 "value": "Thanks for everything Bill"
					 },
					 {
						 "character": "Bill",
						 "value": "You've done me a great kindness, kid. If you ever get outta here, look me up."
					 },
					 {
						 "character": "Bill",
						 "value": "HahahaHAHAHAHA freeedommm!"
					 }
				 ]

var current_dialogue_index := -1
var last_advance_time      := 0


func _on_skip_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _ready() -> void:
	display_next_dialogue()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_dialog"):
		if Time.get_ticks_msec() - last_advance_time < 500:
			return

		display_next_dialogue()
		last_advance_time = Time.get_ticks_msec()


func display_next_dialogue() -> void:
	var dialogText: RichTextLabel  = $"Dialog Text"
	var duckNode: AnimatedSprite2D = $"Comic Duck"
	var fishNode: AnimatedSprite2D = $"Comic Fish"

	current_dialogue_index += 1

	if current_dialogue_index >= dialogues.size():
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		return

	var currentDialogue: Variant = dialogues[current_dialogue_index]

	if currentDialogue["character"] == "Bub":
		duckNode.play()
		fishNode.stop()
	else:
		duckNode.stop()
		fishNode.play()

	var text: String = ""

	if currentDialogue["character"] == "Bub":
		text = "[b][color=light_blue]Bub[/color][/b]\n"
	else:
		text = "[b][color=orange]Bill[/color][/b]\n"

	text += currentDialogue["value"]

	dialogText.text = text