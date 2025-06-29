extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item_sprite
var index: int

signal slot_pressed

func _ready():
	index = get_index()
	
func update(item:Inventory_Item):
	if item == null:
		backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture

func _slot_pressed():
	slot_pressed.emit(index)
