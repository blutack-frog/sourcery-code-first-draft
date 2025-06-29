extends Resource

class_name LearnedSkill

@export var baseskill: Skill
@export var skillXP: Skill_XP_Manager


func learn():
	skillXP.learn()
	skillXP.skill_difficulty = load("res://key resources/Skill Resources/AllSkills.tres").skillDifficulties[baseskill.skillname]

func learnBySkill(skill: Skill):
	baseskill = skill
	skillXP = Skill_XP_Manager.new()
	skillXP.learn()
	var allskills = load("res://key resources/Skill Resources/AllSkills.tres")
	skillXP.skill_difficulty = allskills.skillDifficulties[baseskill.skillname]
	skillXP.levelSpeed = allskills.skillLevelSpeeds[baseskill.skillname]
	
func calcXP(enemyLvl: int):
	var xp = skillXP.calcXPgained(enemyLvl)
	return xp
