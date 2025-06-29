extends BaseDialogueTestScene
class_name Base_Scene


var player: Node2D

@export var scene_objects: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $player
	if global.first_load_in == true:
		#$player.position = Vector2(219,135)
		#$player.position = Vector2(197,129)
		pass
	else:
		$player.position = global.entry_pos
	global.level_loaded.emit()
	#loaditems()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	
func _on_transition_point_body_entered(body, newscene, entryloc):
	if body.has_method("be_player"):
		global.new_scene = newscene
		global.entry_pos = entryloc
		global.is_transitioning = true
		
func _on_transition_point_body_exited(body):
	if body.has_method("be_player"):
		global.is_transitioning = false
		
func go_through_door(newscene, entryloc):
	global.new_scene = newscene
	global.entry_pos = entryloc
	global.is_transitioning = true
		
func change_scene():
	if global.is_transitioning:
		global.first_load_in = false
		global.finish_changing_scene()
		get_tree().change_scene_to_file("res://scenes/locations/"+global.current_scene+".tscn")
		

"""func loaditems():
	var key = $key
	var chest = $chest
	
	if global.key00 == false: key.visible = false
	chest.locked = global.chest00"""

func get_object(name: String):
	for object in scene_objects:
		if object.name == name:
			return object
	return null
