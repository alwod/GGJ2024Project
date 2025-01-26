extends Node2D

var dialogues := [
					 {
						 "character": "Bub",
						 "value": "H-hello. Welcome to the bathtup! Um…my name is [b][color=light_blue]Bub[/color][/b]"
					 },
					 {
						 "character": "Bill",
						 "value": "Yeah yeah, whatever. Look kid, I’m planning my great escape and [color=darkcyan]you’re going to help me[/color]."
					 },
					 {
						 "character": "Bub",
						 "value": "Escape? Help?! I-I can’do something like that."
					 },
					 {
						 "character": "Bill",
						 "value": "Shut that squeak hole before I shut it for you. I'm blowing this popsicle stand."
					 },
					 {
						 "character": "Bill",
						 "value": "..."
					 },
					 {
						 "character": "Bill",
						 "value": "How do I leave?"
					 },
					 {
						 "character": "Bub",
						 "value": "Well…there is a [color=darkcyan]drain on the other side of the bathtub[/color]- but no one has ever made it that far and lived to tell the tale! There’s too many bubbles…toys…and the"
					 },
					 {
						 "character": "Bub",
						 "value": "[color=red]M O N S T E R[/color]"
					 },
					 {
						 "character": "Bill",
						 "value": "Look kid. Look in my fish eyes."
					 },
					 {
						 "character": "Bub",
						 "value": "I-if it means you can never stare in the eyes again, I'll help"
					 },
					 {
						 "character": "Bill",
						 "value": "Good. Now get a move on."
					 },
				 ]

var current_dialogue_index := -1
var last_advance_time := 0


func _on_skip_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


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
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
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