extends Resource

class_name Inventory_Item

@export var name: String = ""
@export var desc: String = ""
@export var texture: Texture2D
@export var resourcepath: String

func use() -> bool:
	return false
