extends Node


var has_talked_to_teacher = false
var has_asked_for_lesson = false
var learned_print = false
var has_tower_key = false

signal learns_print

func _ready() -> void:
	skillbook.updated.connect(check_learned_print)

func check_learned_print():
	for skill in skillbook.skills:
		if skill.baseskill.skillname == "OUTPUT":
			learned_print = true
			break

var chest00: bool = true #tracks if the chest is locked


var key00: bool = true #tracks if the key is still there
