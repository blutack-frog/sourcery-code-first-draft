extends Inventory_Item

class_name Health_Item

var playerHealth = preload("res://key resources/Player_Health.tres")

@export var value: int = 5

func use() -> bool:
	playerHealth.change_health(value)
	return true
