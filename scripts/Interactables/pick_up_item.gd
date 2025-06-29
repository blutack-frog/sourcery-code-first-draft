extends Interactable

class_name PickUpItem

@export var itemType: Inventory_Item

func _ready():
	dialogue_resource = load("res://dialogue/item_dialogue.dialogue")
	dialogue_start = "found_item"

func interact_with(player):
	global.pause_movement = true
	global.interactable = $"."
	global.interactable_name = itemType.name.to_upper()
	if not inventory.isfull():
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "pick_up")
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "inventory_full")
	
	return itemType

func complete():
	inventory.add_item(itemType)
	queue_free()
