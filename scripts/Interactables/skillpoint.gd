extends Interactable

@export var associatedSkill: Skill

func _ready():
	dialogue_resource = load("res://dialogue/skillpoint_dialogue.dialogue")
	dialogue_start = "unlearned"

func interact_with(player):
	global.interactable = $"."
	global.interactable_name = associatedSkill.skillname
	global.pause_movement = true
	#var picked_up: bool = player.inventory.add_item(itemType)
	if skillbook.has_skill(associatedSkill.skillname):
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "learned")
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "unlearned")
			
	
func complete() -> void:
	skillbook.learn(associatedSkill)
