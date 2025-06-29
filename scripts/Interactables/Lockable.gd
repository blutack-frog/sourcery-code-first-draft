extends Interactable

class_name Lockable 

@export var locked: bool = true
@export var lockableName: String

func _ready():
	global.used_key.connect(unlock)

func interact_with(player) -> void:
	global.pause_movement = true
	global.interactable = $"."
	global.interactable_name = lockableName.to_upper()
	if not locked:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "unlocked")
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "locked")
		
func unlock(keyName: String):
	if keyName.to_upper() == lockableName.to_upper() and locked == true:
		locked = false
