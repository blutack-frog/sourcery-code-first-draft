extends XP_Manager

class_name Skill_XP_Manager

@export var skill_difficulty: int #determines how much player XP this skill will yield. value is between 40 (low) and 300 (high)

func calcXPgained(enemyLVL: int):
	var newProblem: float = 1#1.5 if new, 1 if not.
	var problemDifficulty: int = 100 #enemy.difficulty#base xp yield #ranges between 40 (low) and 300 (high) 
	#var enemyLVL = enemy.level
	
	var calc = ((problemDifficulty * enemyLVL)/7)*newProblem
	return calc
	
func learn():
	currentLevel = 1
	currentXP = 0
	maxXP = 8
	maxLevel = 10
	
