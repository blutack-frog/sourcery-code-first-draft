extends Panel

@onready var inputsBox = $MarginContainer/HBoxContainer/VBoxContainer/Input
@onready var answersBox = $MarginContainer/HBoxContainer/VBoxContainer3/Goal
@onready var playerAnswer = $MarginContainer/HBoxContainer/VBoxContainer2/Output
var styleBox: StyleBoxFlat

func loadTest(test:Test):
	if len(test.inputs) == 0:
		inputsBox.text = ""
	else:
		inputsBox.text = str(test.inputs)
	answersBox.text = test.output
	styleBox= $".".get_theme_stylebox("panel").duplicate()
	$".".add_theme_stylebox_override("panel",styleBox)
	styleBox.set("bg_color",Color.DIM_GRAY)
	

func update(output: String, passed:bool):
	playerAnswer.text = output
	#$".".add_theme_stylebox_override("Panel",styleBox)
	if passed:
		styleBox.set("bg_color",Color.WEB_GREEN)
		#testPanels[testNum].get_theme_stylebox("panel").set("bg_color",Color.WEB_GREEN)
	else:
	
		styleBox.set("bg_color",Color.DARK_RED)
		#testPanels[testNum].get_theme_stylebox("panel").set("bg_color",Color.DARK_RED)
