extends Node


signal updated
signal use_item

@export var items: Array[Inventory_Item]

func _ready():
	items = []
	for i in range(16):
		items.append(null)

func add_item(item: Inventory_Item):
	for i in range(items.size()):
		if items[i] == null:
			items[i] = item
			break
	updated.emit()

func add_at_index(index: int,item: Inventory_Item):
	items[index] = item
	updated.emit()

func remove_at_index(index: int) -> void:
	items[index] = null
	updated.emit()
	
func use_item_at_index(index: int) -> void:
	if index < 0 || index >= items.size() || items[index] == null:
		
		return
	var used = items[index].use()
	if used: 
		remove_at_index(index)
		use_item.emit(index)
	
func num_items_in_inventory():
	var numitems:int = 0
	for i in items:
		if i != null: numitems += 1
	return numitems

func isfull():
	return num_items_in_inventory()==items.size()

#connected on player _ready procedure. runs when the global.use_key is emitted.
func use_key(keyName: String):
	for i in range(items.size()):
		if items[i] is Inventory_Key:
			var item = items[i]
			if item.unlocks.to_upper() == keyName.to_upper():
				item.use_key()
				remove_at_index(i)
				break
	
func has_item(name:String):
	for item in items:
		if item != null:
			if item.name == name:
				return true
	return false

func get_item(name:String):
	for item in items:
		if item != null:
			if item.name == name:
				return item
	return null

func use_item_name(name:String):
	for item in items:
		if item != null:
			if item.name == name:
				items.erase(item)
				use_item.emit()
				break
			
	
