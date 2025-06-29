extends Control

@export var enemyRes: Enemy

@onready var enemyName = $Enemy_Info_Panel/MarginContainer/VBoxContainer/HBoxContainer/Enemy_Name

@onready var enemyLVL = $Enemy_Info_Panel/MarginContainer/VBoxContainer/HBoxContainer/Enemy_Level
@onready var problemDesc = $"Problem Description/MarginContainer/VBoxContainer/Description"

@onready var enemyHealthUI = $Enemy_Info_Panel/MarginContainer/VBoxContainer/HealthDisplay
@onready var enemyAnim = $Enemy_anim

func loadEnemy():
	enemyName.text = enemyRes.enemyName
	enemyLVL.text = str(enemyRes.level)
	problemDesc.text = enemyRes.problem.description
	enemyHealthUI.update(enemyRes.health.maxHealth,enemyRes.health.currentHealth,370)
	enemyRes.health.updated.connect(update_health_bar)
	

func update_health_bar():
	enemyHealthUI.update(enemyRes.health.maxHealth,enemyRes.health.currentHealth,370)
