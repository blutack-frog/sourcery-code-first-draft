extends Interactable

class_name Door

@export var newscene: String
@export var entrypoint: Vector2

func interact_with(player) -> void:
	#this gets the 3rd item autoloaded - in this case the global.gd script.
	complete()

func complete():
	get_tree().current_scene.go_through_door(newscene,entrypoint)
