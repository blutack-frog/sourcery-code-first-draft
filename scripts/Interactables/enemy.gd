extends CharacterBody2D

@export var enemy_res: Enemy
const SPEED = 20.0
const JUMP_VELOCITY = -400.0

@export var patrol_points: Array[Marker2D] = []
var current_point_index = 0

func interact_with(player) -> void:
	#get_tree().change_scene_to_file("res://scenes/loading_scene.tscn")
	global.load_battle($".")

func _process(delta:float) -> void:
	patrol()
	move_and_slide()

func patrol() -> void:
	if patrol_points.size() > 0:
		var target = patrol_points[current_point_index].position
		velocity = (target - position).normalized()*SPEED
		
		if position.distance_to(target) < 10.0:
			current_point_index += 1
			if current_point_index >= patrol_points.size():
				current_point_index = 0
