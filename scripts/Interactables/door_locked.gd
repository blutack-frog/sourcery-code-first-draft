extends Door

@export var unlocked_by: String


@export var locked = true

func interact_with(player):
	global.interactable = $"."
	global.pause_movement = true
	
	if locked:
		if inventory.has_item(unlocked_by):
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, "has_key")
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, "locked")
	else:
		#super.interact_with(player)
		complete()

func complete():
	print("go through door")

func use_key():
	inventory.use_item_name(unlocked_by)
		
		
	
		
