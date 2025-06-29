extends Control

var isOpen: bool = false

signal opened
signal closed

@onready var tabs = $Panel/TabContainer
var numtabs: int = 2

func open():
	global.pause_movement = true
	visible = true
	isOpen = true
	tabs.current_tab = 0
	opened.emit()

func close():
	global.pause_movement = false
	visible = false
	isOpen = false
	closed.emit()

func _input(event):
	if event.is_action_pressed("right"):
		if tabs.current_tab == numtabs:
			tabs.current_tab = 0
		else: tabs.current_tab+=1
	if event.is_action_pressed("left"):
		if tabs.current_tab == 0:
			tabs.current_tab = numtabs
		else: tabs.current_tab -= 1
