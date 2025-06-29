extends Resource

class_name AllSkills

@export var allSkills: Array[Skill]

@export var searchableSkills: Dictionary = {
	"print(": "OUTPUT",
	
	"input(": "USER INPUT",
	
	"=":"VARIABLES",
	
	"-":"NUMERACY",
	"/":"NUMERACY",
	"*":"NUMERACY",
	"//":"NUMERACY",
	"%":"NUMERACY",
	
	"int(": "CASTING",
	"str(": "CASTING",
	"bool(": "CASTING",
	"float(": "CASTING",
	
	".len(": "STRINGS",
	".count(": "STRINGS",
	".find(": "STRINGS",
	
	"if ": "SELECTION",
	
	"elif ": "ADVANCED SELECTION",
	"else": "ADVANCED SELECTION",
	
	"==": "BOOLEAN COMPARATORS",
	"!=": "BOOLEAN COMPARATORS",
	"<": "BOOLEAN COMPARATORS",
	">": "BOOLEAN COMPARATORS",
	
	" and ":"BOOLEAN OPERATORS",
	" or ":"BOOLEAN OPERATORS",
	" not ":"BOOLEAN OPERATORS",
	
	"while ": "CONDITIONAL ITERATION",
	
	"for ": "COUNT ITERATION",
	
	"[": "LISTS",
	
	".append(": "MANIPULATION",
	".remove(": "MANIPULATION",
	".insert(": "MANIPULATION",
	".pop(": "MANIPULATION",
	".index(":"MANIPULATION",
	".sort(": "MANIPULATION",
	".reverse(": "MANIPULATION",
	".clear(": "MANIPULATION"
}

var skillDifficulties: Dictionary = {
	"OUTPUT": 40,
	"VARIABLES": 40,
	"USER INPUT": 80,
	"NUMERACY": 100,
	"CASTING": 100,
	"STRINGS": 120,
	"SELECTION": 120,
	"ADVANCED SELECTION": 140,
	"BOOLEAN COMPARATORS": 100,
	"BOOLEAN OPERATORS": 120,
	"CONDITIONAL ITERATION": 200,
	"COUNT ITERATION": 175,
	"LISTS": 190,
	"MANIPULATION": 180
}

var skillLevelSpeeds: Dictionary = {
	"OUTPUT": 4,
	"VARIABLES": 4,
	"USER INPUT": 4,
	"NUMERACY": 3,
	"CASTING": 2,
	"STRINGS": 3,
	"SELECTION": 4,
	"ADVANCED SELECTION": 3,
	"BOOLEAN COMPARATORS": 4,
	"BOOLEAN OPERATORS": 3,
	"CONDITIONAL ITERATION": 2,
	"COUNT ITERATION": 2,
	"LISTS": 2,
	"MANIPULATION": 2
}

func getSkill(name: String):
	for skill in allSkills:
		if skill.skillname == name:
			return skill
	print("ERR: ",name.to_upper()," SKILL RESOURCE DOES NOT EXIST")
	return null
