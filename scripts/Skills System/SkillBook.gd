extends Node

signal updated

@export var xpManager: Player_XP_Manager
@export var skills: Array[LearnedSkill]

func learn(skill:Skill):
	var learned = LearnedSkill.new()
	learned.learnBySkill(skill)
	skills.append(learned)
	updated.emit()
	return learned

#update function that updates skillGUI

func learnByName(name: String):
	
	for skill in load("res://key resources/Skill Resources/AllSkills.tres").allSkills:
		if skill.skillname == name:
			var newskill = LearnedSkill.new()
			newskill.learnBySkill(skill)
			learn(newskill)

func has_skill(name: String):
	for skill in skills:
		if skill.baseskill.skillname == name:
			return true
	return false

func get_skill(name: String):
	for skill in skills:
		if skill.baseskill.skillname == name:
			return skill
	return null
