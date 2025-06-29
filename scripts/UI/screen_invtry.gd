extends MarginContainer

@onready var slots: Array = $HBoxContainer.get_children()
var current_items: Array = [null,null,null,null,null,null,null,null]
const numItems = 8

var isOpen: bool = false



func _ready() -> void:
	inventory.updated.connect(update_scrn_invntry)
	for slot in slots:
		slot.slot_pressed.connect(use_item)
	
func update_scrn_invntry():
	var items: Array = inventory.items
	for i in range(numItems):
		if current_items[i] != items[i]:
			current_items[i] = items[i]
			slots[i].update(items[i])

func use_item(i: int):
	inventory.use_item_at_index(i)
	

	



		
		
