extends Panel

@onready var slots: Array = $left_page/MarginContainer/ScrollContainer/VBoxContainer.get_children()


@onready var skillName = $right_page/MarginContainer/VScrollBar/VBoxContainer/Name
@onready var currentXP = $right_page/MarginContainer/VScrollBar/VBoxContainer/XPDisplay/MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp/HBoxContainer/currentHP
@onready var maxXp = $right_page/MarginContainer/VScrollBar/VBoxContainer/XPDisplay/MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp/HBoxContainer/maxHP
@onready var skillXPbar = $right_page/MarginContainer/VScrollBar/VBoxContainer/XPDisplay/MarginContainer/HBoxContainer/XPBar/MarginContainer/bar_xp
@onready var skillDesc = $right_page/MarginContainer/VScrollBar/VBoxContainer/Description
@onready var skillLVL = $right_page/MarginContainer/VScrollBar/VBoxContainer/XPDisplay/MarginContainer/HBoxContainer/Panel/level
@onready var skillExamples: Array = $right_page/MarginContainer/VScrollBar/VBoxContainer/VBoxContainer.get_children()



var skill_index: int = 0

func _ready():
	skillbook.updated.connect(update)
	for i in slots:
		i.slot_pressed.connect(_on_skill_slot_pressed)
	update()
	display_skill(null)
	slots[0].grab_focus()

func update():
	for i in range(len(slots)):
		if i < skillbook.skills.size():
			slots[i].update(skillbook.skills[i])
		else: slots[i].update(null)
		
func _on_skill_slot_pressed(skill:LearnedSkill):
	display_skill(skill)
	
	
func display_skill(skill: LearnedSkill):
	
	if skill != null:
		$right_page/MarginContainer/VScrollBar.visible = true
		skillName.text = skill.baseskill.skillname
		skillDesc.text = skill.baseskill.skilldesc
		currentXP.text = str(skill.skillXP.currentXP)
		maxXp.text = str(skill.skillXP.maxXP)
		skillXPbar.update(skill.skillXP.maxXP,skill.skillXP.currentXP)
		skillLVL.text = str(skill.skillXP.currentLevel)
		
		
		for i in range(0,skillExamples.size()):
			if i < skill.baseskill.examples.size():
				skillExamples[i].get_child(0).texture = skill.baseskill.examples[i/2]
				skillExamples[i].get_child(1).texture = skill.baseskill.examples[(i/2)+1]
			else:
				skillExamples[i].get_child(0).visible = false
				skillExamples[i].get_child(1).visible = false
	else:
		$right_page/MarginContainer/VScrollBar.visible = false
		#skillName.text = ""
		#skillDesc.text = ""
		#skillLVL.text = ""
		
		#for i in skillExamples:
		#	i.get_child(0).texture = null
		#	i.get_child(1).texture = null
