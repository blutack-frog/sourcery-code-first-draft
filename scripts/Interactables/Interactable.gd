extends PhysicsBody2D

class_name Interactable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
@export var id: String = ""

func interact_with(player) -> void:
	global.interactable = $"."
	global.pause_movement = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	return
	
func complete() -> void: pass
