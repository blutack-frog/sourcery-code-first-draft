extends Node

var enemyEngaged: Node2D

var interactable: Interactable
var interactable_name: String

var keys: Array[String] = []
#connects to inventory.use_key and lockable.unlock
signal used_key
signal npc_walk
signal level_loaded

var pause_movement = false

var current_scene = "dungeon"
var new_scene = ""
var entrypoint = Vector2(0,0)
var is_transitioning = false
var player: CharacterBody2D

var entry_pos: Vector2

var first_load_in = true

var key00 = true
var chest00 = true

signal confirm_interaction

func _ready():
	confirm_interaction.connect(_on_confirm_interaction)
	player = get_player()
	level_loaded.emit()

func get_player():
	player = get_tree().current_scene.find_child("player")
	return player
	
func _on_confirm_interaction():
	interactable.complete()
	
func finish_changing_scene():
	if is_transitioning:
		current_scene = new_scene
		new_scene = ""
		is_transitioning = false
	level_loaded.emit()
		

var battle = preload("res://scenes/BattleScenev3.tscn")

func load_battle(enemyNode: Node2D):
	enemyEngaged = enemyNode
	#play transition screen
	var enemy = enemyNode.enemy_res
	get_tree().paused = true
	var battleTemp = battle.instantiate()
	add_child(battleTemp)
	battleTemp.battleWon.connect(won_battle)
	battleTemp.battleLost.connect(lost_battle)
	battleTemp.loadEnemy(enemy)


func won_battle():
	enemyEngaged.queue_free()

func lost_battle():
	SaveManager.load_game()
