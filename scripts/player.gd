extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 2#0 is up, 1 is right, 2 is down, 3 is left.
var moved_by_dialogue = false
var dialogue_destination: Vector2

var items_in_range: Array[PhysicsBody2D] = []

var player #what is the purpose of this?


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)
	global.used_key.connect(inventory.use_key)
	
func _on_dialogue_manager_dialogue_ended(resource: DialogueResource) -> void:
	global.pause_movement = false

func _physics_process(delta: float):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var is_walking = 1
	if global.pause_movement == false:
		if Input.is_action_pressed("ui_up"):
			direction = 0
			velocity.x = 0
			velocity.y = -SPEED
		elif Input.is_action_pressed("ui_down"):
			direction = 2
			velocity.x = 0
			velocity.y = SPEED
		elif Input.is_action_pressed("ui_left"):
			direction = 3
			velocity.x = -SPEED
			velocity.y = 0
		elif Input.is_action_pressed("ui_right"):
			direction = 1
			velocity.x = SPEED
			velocity.y = 0
		else:
			is_walking = 0
			velocity.x = 0
			velocity.y = 0
		if Input.is_action_just_pressed("interact"):
			interact()
		play_anim(is_walking)

		move_and_slide()

func _process(delta: float) -> void:
	var is_walking
	if moved_by_dialogue == true:
		is_walking = true
		if position.distance_to(dialogue_destination) < 10:
			moved_by_dialogue = false
			is_walking = false
		elif moved_by_dialogue:
			velocity = position.direction_to(dialogue_destination).normalized() * SPEED
		play_anim(is_walking)
		move_and_slide()

func play_anim(mvmt_code):
	var anim = $AnimatedSprite2D
	var dir = direction
	var animations = [["idle_back","idle_side","idle_front"],
	["run_back","run_side","run_front"]]
	
	if direction == 3:
		anim.flip_h = false
		dir = 1
	else:
		anim.flip_h = true
	anim.play(animations[mvmt_code][dir])


func walk(dest: Array[int]):
	dialogue_destination = Vector2(dest[0],dest[1])
	moved_by_dialogue = true
	
func interact():
	#get direction
	if len(items_in_range) > 0:
		var dir = Vector2(0,-1)
		if direction == 1: dir = Vector2(1,0)
		elif direction == 2: dir = Vector2(0,1)
		elif direction == 3: dir = Vector2(-1,0)
		var player_pos = Vector2(get_position())
	
		for body in items_in_range:
			var item_pos = Vector2(body.position)
			var relative_pos = (item_pos - player_pos).round()
			
			#next line uses dot product to calculate how aligned the player's direction and the direction of the item are
			#if the player is facing the item it counts as interacting.
			if (relative_pos.x*dir.x + relative_pos.y*dir.y) > 0:
				var item = body.interact_with($".")
				break


func _on_interaction_area_body_entered(body):
	if body.has_method("interact_with"):
		items_in_range.append(body)


func _on_interaction_area_body_exited(body):
	if items_in_range.has(body):
		items_in_range.erase(body)
	pass # Replace with function body.
	
func be_player():
	pass
	
func has_skill(name:String):
	return skillbook.has_skill(name)

func has_item(name: String):
	return inventory.has_item(name)
