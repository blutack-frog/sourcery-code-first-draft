extends Panel

#@onready var backgroundSprite: Sprite2D = $background
#@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item_sprite

var associatedSkill: LearnedSkill = null

@onready var skillName: Label = $MarginContainer/CenterContainer/VBoxContainer/SkillName
@onready var skillLVL: Label = $MarginContainer/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/LVL_num
@onready var skillXP: Label = $MarginContainer/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/Panel/HBoxContainer/XP_current
@onready var maxXP: Label = $MarginContainer/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/Panel/HBoxContainer/XP_goal
@onready var xpBar: Panel = $MarginContainer/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/Panel

var index: int

signal slot_pressed

func _ready():
	index = get_index()
	
func update(skill:LearnedSkill):
	if skill == null:
		$".".visible = false
	else:
		$".".visible = true
		associatedSkill = skill
		skillName.text = skill.baseskill.skillname
		skillLVL.text = str(skill.skillXP.currentLevel)
		skillXP.text = str(skill.skillXP.currentXP)
		maxXP.text = str(skill.skillXP.maxXP)
		xpBar.update(skill.skillXP.maxXP,skill.skillXP.currentXP)

func _slot_pressed():
	slot_pressed.emit(associatedSkill)
