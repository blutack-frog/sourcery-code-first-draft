extends CharacterBody2D

class_name NPC

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
@export var id: String = ""
@export var speed = 100

var destination: Vector2
var isWalking: bool = false


func walk(where_to):
	#walk from current location to where_to
	destination = Vector2(where_to[0],where_to[1])
	isWalking = true
		
	
func _process(delta:float) -> void:
	if position.distance_to(destination) < 10:
		isWalking = false
	elif isWalking:
		velocity = position.direction_to(destination).normalized() * speed
		if position.distance_to(destination) > 10:
			move_and_slide()
	

func _ready():
	global.npc_walk.connect(walk)
	
func interact_with(player) -> void:
	global.pause_movement = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	return
	
func complete() -> void: pass
