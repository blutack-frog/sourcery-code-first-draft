extends Panel


@onready var player = preload("res://scenes/player.tscn")
@onready var health = preload("res://key resources/Player_Health.tres")
@onready var xp = preload("res://key resources/Player_XP.tres")

@onready var currenthealth = $left_page/MarginContainer/VBox/HealthDisplay/MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health/HBoxContainer/currentHP
@onready var maxhealth = $left_page/MarginContainer/VBox/HealthDisplay/MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health/HBoxContainer/maxHP
@onready var currentXP = $left_page/MarginContainer/VBox/XPDisplay/MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp/HBoxContainer/currentHP
@onready var maxXP = $left_page/MarginContainer/VBox/XPDisplay/MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp/HBoxContainer/maxHP
@onready var level = $left_page/MarginContainer/VBox/PanelContainer/Panel/HBoxContainer/level

@onready var healthBar = $left_page/MarginContainer/VBox/HealthDisplay/MarginContainer/HBoxContainer/HealthBar/MarginContainer/bar_health
@onready var xpBar = $left_page/MarginContainer/VBox/XPDisplay/MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp

func _ready():
	health.updated.connect(update)
	xp.updated.connect(update)
	update()

func update():
	currenthealth.text = str(health.currentHealth)
	maxhealth.text = str(health.maxHealth)
	healthBar.update(health.maxHealth,health.currentHealth)
	
	currentXP.text = str(xp.currentXP)
	maxXP.text = str(xp.maxXP)
	xpBar.update(xp.maxXP,xp.currentXP)
	
	level.text = str(xp.currentLevel)
