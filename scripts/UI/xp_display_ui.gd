extends Panel


func update(maxVal:int, currentVal: int, barLen: int):
	$MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp.maxLen = barLen
	$MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp.update(maxVal,currentVal)
	$MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp/HBoxContainer/currentHP.text = str(currentVal)
	$MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp/HBoxContainer/maxHP.text = str(maxVal)
