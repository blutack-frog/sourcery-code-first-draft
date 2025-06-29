extends Resource

class_name CodeRunner

var code_text_filename: String = "current_code"

#an array consisting of [r_zval_qn0, r_zval_qn1] and so on
#these values replace input()s in the code, so that their values can be passed in when executed
var argument_names: Array = []
#i used "r_zval_qn" to replace the keyword input() as it's unlikely the user used this as a variable name
#so the value will not be unwittingly overwritten by the user's own code.
#might change this to input1 and so on...
var nonsenseArgName = "r_zval_qn"

var inputLiteral = "input("


func save_as_text_file(code: String):
	argument_names = []
	var file = FileAccess.open("scripts/"+code_text_filename+".txt",FileAccess.WRITE)
	if inputLiteral in code:
		code = convert_to_function(code)
	file.store_string(code)
	file.close()
	
func find_arg_indexes(code:String, num_args: int):
	var arg_indexes: Array[int] = []
	var index = 0
	while code.find(inputLiteral,index) > -1:
		index = code.find(inputLiteral,index)
		arg_indexes.append(index)
		index += 1
	return arg_indexes
	
func remove_inputs(code:String):
	var num_args: int = code.count(inputLiteral)
	var arg_names: Array[String] = []
	for i in range(num_args):
		arg_names.append(nonsenseArgName+str(i))
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
	#if len(argument_names) > 0:
	for i in range(len(argument_names)):
		if i < len(inputs):
			to_pass.append(inputs[i])
		else:
			to_pass.append("0")
	OS.execute("python",to_pass,output,true)
	var to_show:String = output[0]
	
	if  to_show.begins_with("Traceback"):
		to_show = strip_error(to_show.split("\r\n"))
		
	return to_show

func strip_error(error:PackedStringArray):
	var line1:String = error[1].split(",")[1]
	var line2:String = error[2]
	var line3:String = error[3]
	return line1+": "+line2+"\n"+line3



func save_code(code):
	save_as_text_file(code)

func run_code(inputs):
	var output: String = execute_code(inputs)
	return output
