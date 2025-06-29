extends Inventory_Item

class_name Inventory_Key

@export var unlocks:String

func use() -> bool:
	return false

func use_key():
	pass#global.keys.erase(unlocks.to_upper())
