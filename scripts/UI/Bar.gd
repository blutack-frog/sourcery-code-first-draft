extends Panel

@export var maxLen: int = 276
var currentLen:int = 276

func update(maxVal: int, currentVal: int):
	var percentage: float = float(currentVal)/float(maxVal)
	currentLen = int(maxLen*percentage)
	if currentLen < 10:
		currentLen = 10
	$".".custom_minimum_size.x = currentLen
