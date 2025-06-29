extends Control

@onready var save_button: Button = $VBoxContainer/Button_SAVE
@onready var load_button: Button = $VBoxContainer/Button_LOAD

var isPaused: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if isPaused: 
			hide_pause_menu()
		else: 
			show_pause_menu()
	get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	global.pause_movement = true
	visible = true
	isPaused = true
	save_button.grab_focus()
	
func hide_pause_menu() -> void:
	global.pause_movement = false
	visible = false
	isPaused = false
	
func _on_save_pressed() -> void:
	if isPaused == false:
		return
	SaveManager.save_game()

func _on_load_pressed() -> void:
	if isPaused == false:
		return
	SaveManager.load_game()
