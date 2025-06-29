extends CanvasLayer

signal battleWon
signal battleLost

signal finishedTests
signal xpAdded
signal playerxpAdded

var pauseTime = 0.8


@export var codeRunner: CodeRunner
@onready var testPanels = $TestsPanel/ScrollContainer/MarginContainer/VBoxContainer.get_children()
@onready var playerHealth: HealthManager = preload("res://key resources/Player_Health.tres")
@onready var playerXP: Player_XP_Manager = preload("res://key resources/Player_XP.tres")

@onready var allskills: AllSkills = preload("res://key resources/Skill Resources/AllSkills.tres")

@export var enemyHealth: HealthManager
var enemyAnim
var tests: Array[Test]

var en: Enemy
var cod: String

@onready var MssgBox = $MessageBox


func loadEnemy(enemy: Enemy):
	$Enemy.enemyRes = enemy
	en = enemy
	enemyHealth = enemy.health
	enemyHealth.defeated.connect(enemyDefeated)
	playerHealth.defeated.connect(playerDefeated)
	
	if enemy.startingCode != null:
		$Code_Panel/MarginContainer/CodeEdit.text = enemy.startingCode
	
	$Enemy.loadEnemy()
	enemyAnim = $Enemy/Enemy_anim
	enemyAnim.play("idle_front")
	await get_tree().create_timer(pauseTime).timeout
	say(enemy.enemyName+" APPEARED")
	tests = enemy.problem.tests
	for i in range(tests.size()):
		testPanels[i].loadTest(tests[i])
		testPanels[i].visible = true
		await get_tree().create_timer(pauseTime).timeout
	
func run_code_button_pressed():
	var code: String = get_code()
	cod = code
	codeRunner.save_code(code)
	
	for i in range(min(tests.size(),testPanels.size())):
		var test = tests[i]
		var output: String = codeRunner.run_code(test.inputs)
		
		if not test.passed(output):
			testPanels[i].update(output,false)
			if isError(output):
				playerHealth.change_health(-1)
				say("TEST "+str(i)+" FAILED: ERROR")
				await get_tree().create_timer(pauseTime).timeout
				say("PLAYER TAKES 1 DMG")
				await get_tree().create_timer(pauseTime).timeout
				
				
			else: 
				say("TEST "+str(i)+" FAILED: INCORRECT")
				await get_tree().create_timer(pauseTime).timeout
				say("PLAYER TAKES 2 DMG")
				await get_tree().create_timer(pauseTime).timeout
				playerHealth.change_health(-2)
			break
			
			
		else:
			testPanels[i].update(output,true)
			say("TEST "+str(i)+" PASSED")
			
			enemyHealth.change_health(-1)
			say("ENEMY TAKES 1 DMG")
			enemyAnim.play("hurt")
			await get_tree().create_timer(pauseTime).timeout
			
	finishedTests.emit()

func enemyDefeated():
	await finishedTests
	say("YOU WON")
	await get_tree().create_timer(pauseTime).timeout
	
	var skillsUsed: Array[String]  = calcSkills(cod)
	var skill: LearnedSkill
	var num = 0
	for skillname in skillsUsed:
		skill = skillbook.get_skill(skillname)
		var xp: int = skill.calcXP(en.level)
		addSkillXP(xp, skill)
		num += 1
		await xpAdded
		#if num == len(skillsUsed)-1: xpAdded.emit()
	
	battleWon.emit()
	end_battle()

func playerDefeated():
	await finishedTests
	say("PLAYER DEFEATED")
	await get_tree().create_timer(pauseTime).timeout
	battleLost.emit()
	end_battle()

func flee_button_pressed():
	say("YOU SUCCESFULLY FLED THE BATTLE")
	end_battle()

func end_battle():
	get_tree().paused = false
	queue_free()



func say(mssg: String) -> void:
	MssgBox.visible = true
	$MessageBox/MarginContainer/Label.text = mssg
	await get_tree().create_timer(pauseTime).timeout

	MssgBox.visible = false

func view_items_button_pressed():
	pass
	
	


func get_code():
	return $Code_Panel/MarginContainer/CodeEdit.text
	
func isError(string: String):
	#error needs sanitising! so it's easy for beginners to understand. Remove the Traceback part...
	return string.begins_with("Traceback")
	


func calcSkills(code):
	var searchterms = allskills.searchableSkills.keys()
	var usedSkills: Array[String] = []
	for term in searchterms:
		if isInCodeAndValid(term,code):
			var skillname = allskills.searchableSkills[term]
			usedSkills.append(skillname)
			if not skillbook.has_skill(skillname):
				var skill: Skill = allskills.getSkill(skillname)
				learnNewSkill(skill)
	return usedSkills
	
func isInCodeAndValid(term, code):
	var pos = 0
	while pos >= 0 and pos < len(code):
		pos = code.find(term, pos)
		if pos == 0:
			return true
		elif pos == -1:
			return false
		elif term[0] == ".":
			return true
		elif code[pos-1] == " " or code[pos-1] == "\n" or code[pos-1] == "\t":
			#so that == is not counted as a =
			if term != "=" or (term=="=" and code[pos+1]!="=") or (term =="/" and code[pos+1] != "/"):
				return true
		pos += 1
	return false
	
	
	
func learnNewSkill(skill:Skill):
	var newskill: LearnedSkill = skillbook.learn(skill)
	await skillbook.updated
	say("YOU USED A NEW SKILL: "+skill.skillname.to_upper())
	await get_tree().create_timer(pauseTime).timeout
	var playerxp = playerXP.calcXPgained(newskill)
	addPlayerXP(playerxp)

func addSkillXP(xp: int, skill: LearnedSkill):
	say(skill.baseskill.skillname.to_upper()+" GAINED "+str(xp)+" XP")
	await get_tree().create_timer(pauseTime).timeout

	var prevLvl = skill.skillXP.currentLevel

	skill.skillXP.addXP(xp)

	var lvlChange = skill.skillXP.currentLevel - prevLvl
	for x in range(lvlChange):
		say(skill.baseskill.skillname.to_upper()+" HAS LEVELED UP. IT IS NOW LEVEL "+str(prevLvl+x+1))
		await get_tree().create_timer(pauseTime).timeout
		var playerxp = playerXP.calcXPgained(skill)
		addPlayerXP(playerxp)
		await playerxpAdded
	xpAdded.emit()

func addPlayerXP(playerxp: int):
	var prevPlayerlvl = playerXP.currentLevel
	playerXP.addXP(playerxp)
	say("YOU GAINED "+str(playerxp)+" XP")
	await get_tree().create_timer(pauseTime).timeout
	for i in range(playerXP.currentLevel-prevPlayerlvl):
		say("LEVEL UP. YOU ARE NOW LEVEL "+str(prevPlayerlvl+i+1))
		await get_tree().create_timer(pauseTime).timeout
	playerxpAdded.emit()


	
