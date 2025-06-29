extends Panel

@onready var slots: Array = $left_page/MarginContainer/GridContainer.get_children()


@onready var itemName = $right_page/MarginContainer/VBoxContainer/Name
@onready var itemIcon = $right_page/MarginContainer/VBoxContainer/Icon
@onready var itemDesc = $right_page/MarginContainer/VBoxContainer/Description

@onready var confirmWindow = $right_page/MarginContainer/VBoxContainer/HBoxContainer/Bin_Button/ConfirmationDialog

var item_index: int = 0

func _ready():
	inventory.updated.connect(update)
	for i in slots:
		i.slot_pressed.connect(_on_item_slot_pressed)
	update()
	display_item(null)
	slots[0].grab_focus()

func update():
	for i in range(inventory.items.size()):
		slots[i].update(inventory.items[i])
		
func _on_item_slot_pressed(index: int):
	item_index = index
	display_item(inventory.items[index])

func display_item(item: Inventory_Item):
	if item != null:
		itemName.text = item.name
		itemDesc.text = item.desc
		itemIcon.texture = item.texture
	else:
		itemName.text = ""
		itemDesc.text = ""
		itemIcon.texture = null



func _on_bin_button_pressed():
	confirmWindow.visible = true

func _on_confirmation_dialog_confirmed():
	if item_index > -1:
		inventory.remove_at_index(item_index)
		display_item(null)


func _on_confirmation_dialog_canceled():
	confirmWindow.visible = false


func _on_use_button_pressed():
	print(item_index)
	if item_index > -1:
		inventory.use_item_at_index(item_index)
		display_item(null)
