extends Resource

class_name HealthManager

signal updated
signal defeated

@export var maxHealth: int
@export var currentHealth: int

func change_health(amount: int):
	if currentHealth + amount > maxHealth:
		currentHealth = maxHealth
	elif currentHealth + amount <= 0:
		currentHealth = 0
		defeated.emit()
	else:
		currentHealth += amount
	updated.emit()
