extends Resource

class_name XP_Manager

@export var currentXP: int
@export var maxXP: int
@export var currentLevel: int
@export var maxLevel: int

@export var levelSpeed: int #1 is fast, 4 is slow

signal updated

func addXP(amount:int):
	currentXP += amount
	while currentXP > maxXP:
		currentXP = currentXP - maxXP
		levelUp()
	updated.emit()

func levelUp():
	if not currentLevel == maxLevel:
		currentLevel += 1
		calcMaxXP()

func calcMaxXP():
	if levelSpeed == 1:
		maxXP = roundi(4*(currentLevel**3)/5)
	elif levelSpeed == 2:
		maxXP = currentLevel**3
	elif levelSpeed == 3:
		maxXP = roundi((6*(currentLevel**3)/5) - 15*(currentLevel**2) + 100*currentLevel - 140)
	elif levelSpeed == 4:
		maxXP = roundi(5*(currentLevel**3)/4)
		
func calcXP(enemyLevel: int):
	pass
		
