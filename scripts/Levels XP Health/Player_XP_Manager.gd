extends XP_Manager

class_name Player_XP_Manager



func calcXPgained(skill: LearnedSkill):
	var skillYield = skill.skillXP.skill_difficulty
	return roundi(randf_range(0.9,1.1)*skillYield)
