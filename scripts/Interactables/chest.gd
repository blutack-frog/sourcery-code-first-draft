extends Interactable


func interact_with(player):
	#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "open_locked_chest")
	global.pause_movement = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	return
