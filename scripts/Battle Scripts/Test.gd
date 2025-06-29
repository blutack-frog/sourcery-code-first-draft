extends Resource

class_name Test

@export var inputs: Array[String]
@export var output: String


func passed(value: String):
	return value.strip_edges() == output
