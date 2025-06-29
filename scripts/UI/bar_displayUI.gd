extends Panel



func update(maxVal:int, currentVal: int, barLen: int):
	$MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health.maxLen = barLen
	$MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health.update(maxVal,currentVal)
	$MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health/HBoxContainer/currentHP.text = str(currentVal)
	$MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health/HBoxContainer/maxHP.text = str(maxVal)
	
