extends Control

@onready var playerXPManager = preload("res://key resources/Player_XP.tres")
@onready var playerHealth = preload("res://key resources/Player_Health.tres")

@onready var playerHealthUI = $PanelContainer/VBoxContainer/Player_Info_Panel/MarginContainer/VBoxContainer/HealthDisplay
@onready var playerXPUI = $PanelContainer/VBoxContainer/Player_Info_Panel/MarginContainer/VBoxContainer/XPDisplay
@onready var playerLevel = $PanelContainer/VBoxContainer/HBoxContainer/levelNum
@onready var playerSprite = $PanelContainer/VBoxContainer/HBoxContainer/Sprite2D

func _ready():
	playerLevel.text = str(playerXPManager.currentLevel)
	update_health_bar()
	update_xp_bar()
	playerHealth.updated.connect(update_health_bar)
	
	

func update_health_bar():
	playerHealthUI.update(playerHealth.maxHealth,playerHealth.currentHealth,274)
	
func update_xp_bar():
	playerXPUI.update(playerXPManager.maxXP,playerXPManager.currentXP,274)
