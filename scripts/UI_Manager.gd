extends CanvasLayer

@onready var book = $GuiBook
@onready var pause = $PauseMenu

@onready var invntry = $Node/MarginContainer
@onready var invntry_button = $invntry_button
@onready var highlighter = $Node/current_item_highlight
var focus_index: int = 0
var highlighter_pos = 81

var skillbook_enabled = true
var invntry_enabled = true

func _ready():
	book.close()
	pause.visible = false
	invntry.visible = false
	highlighter.visible = false

func _input(event):
	if skillbook_enabled:
		if event.is_action_pressed("toggle_book"):
			if not book.isOpen:
				open_book()
			else:
				book.close()
	if invntry_enabled:
		if event.is_action_pressed("toggle_inventory"):
			if not invntry.isOpen:
				open_inventory()
			else: close_inventory()
	if event.is_action_pressed("close"):
		if book.isOpen:
			book.close()
		elif invntry.isOpen:
			close_inventory()
	if event.is_action_pressed("right") and invntry.isOpen:
		set_focus(focus_index+1)
	if event.is_action_pressed("left") and invntry.isOpen:
		set_focus(focus_index-1)
	if event.is_action_pressed("ui_accept") and invntry.isOpen:
		inventory.use_item_at_index(focus_index)
		
func open_inventory():
	global.pause_movement = true
	invntry.visible = true
	invntry_button.visible = false
	highlighter.visible = true
	invntry.isOpen = true
	set_focus(0)

func close_inventory():
	global.pause_movement = false
	invntry.isOpen = false
	invntry.visible = false
	invntry_button.visible = true
	highlighter.visible = false

func open_book():
	if not book.isOpen:
		book.open()

func set_focus(x:int):
	if x >= 0 and x < 8:
		focus_index = x
		highlighter.position.x = highlighter_pos + (x*64)

	
