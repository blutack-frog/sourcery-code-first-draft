extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scenes()
	pass
	
func change_scenes():
	if global.is_transitioning:
		if global.current_scene == "level2":
			global.finish_changing_scene()
			get_tree().change_scene_to_file(("res://scenes/locations/dungeon.tscn"))


func _on_ladder_to_dungeon_entered(body):
	if body.has_method("be_player"):
		global.is_transitioning = true


func _on_ladder_from_dungeon_exited(body):
	if body.has_method("be_player"):
		global.is_transitioning = false
