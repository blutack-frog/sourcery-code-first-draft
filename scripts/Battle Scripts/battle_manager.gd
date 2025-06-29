extends CanvasLayer

var code_outputs: Array[Label] = []
var code_input: CodeEdit
var expected_outputs: Array[Label] = []
var testPanels: Array[PanelContainer] = []
var arguments:Array[Label] = []

var code_text_filename: String = "current_code"

var argument_names: Array = []

func _ready():
	#code_output = $HBoxContainer/tests/test_panel/MarginContainer/VBoxContainer/outputs/act_out_panel/actual_output
	code_input = $MarginContainer/HBoxContainer/inputs/CodeEdit
	#expected_output = $HBoxContainer/tests/test_panel/MarginContainer/VBoxContainer/outputs/exp_out_panel/expected_output
	
	var numTestPanels: int = $MarginContainer/HBoxContainer/tests.get_child_count()/2
	for i in range(numTestPanels):
		var panel: PanelContainer
		if i == 0:
			panel = $MarginContainer/HBoxContainer/tests.get_node("test_panel")
		else:
			panel = $MarginContainer/HBoxContainer/tests.get_node("test_panel"+str(i+1))
		testPanels.append(panel)
		code_outputs.append(panel.get_node("./MarginContainer/VBoxContainer/outputs/act_out_panel/actual_output"))
		expected_outputs.append(panel.get_node("./MarginContainer/VBoxContainer/outputs/exp_out_panel/expected_output"))
		arguments.append(panel.get_node("./MarginContainer/VBoxContainer/inputs_and_check/inputs2/inputs"))
		
	

#EXIT BUTTON
func _on_button_pressed():
	get_tree().paused = false
	queue_free()
	pass
	
func save_as_text_file(text: String):
	argument_names = []
	var file = FileAccess.open("scripts/"+code_text_filename+".txt",FileAccess.WRITE)
	var code = code_input.text
	if "input(" in code:
		code = convert_to_function(code)
	file.store_string(code)
	file.close()
	
func find_arg_indexes(code:String, num_args: int):
	var arg_indexes: Array[int] = []
	var index = 0
	while code.find("input(",index) > -1:
		index = code.find("input(",index)
		arg_indexes.append(index)
		index += 1
	return arg_indexes
	
func remove_inputs(code:String):
	var num_args: int = code.count("input")
	var arg_names: Array[String] = []
	for i in range(num_args):
		arg_names.append("r_zval_qn"+str(i))
	var arg_indexes : Array[int] = find_arg_indexes(code, num_args)
	
	arg_indexes.reverse()
	for i in range(num_args):
		var argument: String = arg_names[num_args-1-i]
		var index: int = arg_indexes[i]
		var end:int = code.find(")",index)
		code = code.left(index)+argument+code.right(len(code)-(end+1))
	return [code, arg_names]

func convert_to_function(code):
	var returned = remove_inputs(code)
	code = returned[0]
	var arg_names = returned[1]
	argument_names = arg_names
	
	code = code.split("\n")
	for i in range(len(code)):
		code[i] = "	"+code[i]
	code = "\n".join(code)
	var x = "import sys\ndef code("
	for name in arg_names:
		x = x + name + ","
	x = x.left(-1)
	x = x + "):\n"+code
	
	var main_func: String = "\nif __name__==\"__main__\":\n	code("
	for arg in range(len(arg_names)):
		main_func+= "sys.argv["+str(arg+1)+"]," 
	main_func = main_func.left(-1)+")"
	
	x = x + main_func
	return x

func execute_code(inputs:Array[String]):
	
	var nothing= []
	var output = []
	var folder = OS.get_executable_path().get_base_dir()
	OS.execute("cmd",["/c","cd "+folder],nothing)
	OS.execute("cmd",["/c", "dir"],nothing)
	
	var to_pass = ["scripts/"+code_text_filename+".txt"]
	if len(argument_names) > 0:
		for i in range(len(argument_names)):
			if i < len(inputs):
				to_pass.append(inputs[i])
			else:
				to_pass.append("0")
	OS.execute("python",to_pass,output,true)
	var to_show:String = output[0]
	if  to_show.begins_with("Traceback"):
		print("BEFORE:",to_show)
		to_show = strip_error(to_show.split("\r\n"))
		print("AFTER:",to_show)
		
	return to_show

func strip_error(error:PackedStringArray):
	var line1:String = error[1].split(",")[1]
	var line2:String = error[2]
	var line3:String = error[3]
	return line1+": "+line2+"\n"+line3

func get_inputs(num_test: int):
	var input_string = arguments[num_test].text
	var args = input_string.split(" ")
	return args

func is_test_passed(testNum:int):
	var exp = expected_outputs[testNum].text
	var act = code_outputs[testNum].text.strip_edges()
	return exp==act

func colour_test(testNum: int, testPassed:String):
	var styleBox: StyleBoxFlat = testPanels[testNum].get_theme_stylebox("panel").duplicate()
	testPanels[testNum].add_theme_stylebox_override("panel",styleBox)
	if testPassed == "true":
		styleBox.set("bg_color",Color.WEB_GREEN)
		#testPanels[testNum].get_theme_stylebox("panel").set("bg_color",Color.WEB_GREEN)
	elif testPassed == "false":
	
		styleBox.set("bg_color",Color.DARK_RED)
		#testPanels[testNum].get_theme_stylebox("panel").set("bg_color",Color.DARK_RED)
	else:
		styleBox.set("bg_color",Color.DIM_GRAY)
	
	
#RUN CODE BUTTON
func _on_button_run_code_pressed():
	var code: String = code_input.text
	
	save_as_text_file(code)
	
	#rest each test to grey and set output to ""
	for i in range(len(testPanels)):
		code_outputs[i].text = ""
		colour_test(i,"")
	
	#compare the output for each test, and colour the panel green/red if the test passes/fails
	for i in range(len(testPanels)):
		var inputs = get_inputs(i)
		var output:String = execute_code(inputs)
		code_outputs[i].text = output
		var test_passed: bool = is_test_passed(i)
		colour_test(i,str(test_passed))
		if test_passed == false:
			break
