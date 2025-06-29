extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save: Dictionary = {
	scene_path = "",
	player = {
		name = "PLAYER",
		pos_x = 0,
		pos_y = 0,
		hp = 1,
		max_hp = 1,
		xp = 1,
		max_xp = 1,
		level = 1
	},
	items = [],
	skills = []
}

func save_game() -> void:
	update_player_data()
	update_scene_path()
	update_inventory()
	update_skillbook()
	save_data()
	game_saved.emit()
	
func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav",FileAccess.READ)
	var load_json = JSON.new()
	load_json.parse(file.get_line())
	var save_dict : Dictionary = load_json.get_data() as Dictionary
	current_save = save_dict
	
	#load level using scene path and positions
	global.new_scene = get_scenename_from_filepath(current_save.scene_path)
	get_tree().change_scene_to_file(current_save.scene_path)
	
	await global.level_loaded
	var player = global.get_player()
	var position = Vector2(current_save.player.pos_x,current_save.player.pos_y)
	player.position = position
	
	load_inventory()
	load_skillbook()
	
func update_player_data() -> void:
	var p = global.get_player()
	current_save.player.pos_x = p.position[0]
	current_save.player.pos_y = p.position[1]

func save_data() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav",FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)

func update_scene_path() -> void:
	var p: String = get_tree().current_scene.scene_file_path
	current_save.scene_path = p
	
func get_scenename_from_filepath(filepath: String):
	var splitpath = filepath.split("/")
	var lastbit = splitpath[len(splitpath)-1]
	return lastbit.substr(0,len(lastbit)-5)

func load_new_game():
	current_save.scene_path = "res://scenes/locations/bedroom.tscn"
	current_save.player.pos_x = 97
	current_save.player.pos_y = 37
	current_save.items = ["","","","","","","","","","","","","","","",""]
	save_data()
	load_game()
	
func update_inventory() -> void:
	var inv = global.get_player().inventory
	var saved_inventory = []
	for item in inv.items:
		if item != null:
			saved_inventory.append(item.resourcepath)
		else:
			saved_inventory.append("")
	current_save.items = saved_inventory

func load_inventory() -> void:
	for i in range(len(inventory.items)):
		if current_save.items[i] != "":
			var item: Inventory_Item = load(current_save.items[i])
			inventory.add_at_index(i,item)
		else: inventory.items[i] = null

func load_skillbook() -> void:
	skillbook.skills.clear()
	for item in current_save.skills:
		var skill: LearnedSkill = LearnedSkill.new()
		skill.baseskill = load(item[0])
		print(skill.baseskill.skillname)
		skill.skillXP = Skill_XP_Manager.new()
		skill.skillXP.currentLevel = int(item[1])
		skill.skillXP.currentXP = int(item[2])
		skill.skillXP.maxXP = int(item[3])
		skillbook.skills.append(skill)
	skillbook.updated.emit()

func update_skillbook():
	var saved_skills = []
	for skill: LearnedSkill in skillbook.skills:
		var saved_skill = []
		saved_skill.append(skill.baseskill.resourcepath)
		saved_skill.append(skill.skillXP.currentLevel)
		saved_skill.append(skill.skillXP.currentXP)
		saved_skill.append(skill.skillXP.maxXP)
		saved_skills.append(saved_skill)
		
	current_save.skills = saved_skills
	
	
			
			
			
