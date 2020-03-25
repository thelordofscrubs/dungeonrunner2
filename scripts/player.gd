extends Node
class_name Player

enum TILE{FLOOR,WALL,FINISH,DOOR,CHEST,CHESTOPEN,CHARSPRITE,BLUESLIME,KEY,POT,BATSKELETON,DOOROPEN,BLUESLIMESIDE, OOB = -1}
enum LOOT{ARROW,GELD}

var health
var mana = 100
var atkS = 5
var atkM
var totalDamage
var coordinates
var screenCoordinates
var initialCoordinates
var isAttacking = false
var sprite
var facing = Vector2(0,1)
var keys = 5
var money = 0
var healthBar
var manaBar
var moneyDisplay
var keyDisplay
var arrowDisplay
var weaponDisplay
var isDead = false
var attackSpeed = 1
var weapons = ["sword","bow"]
var currentWeapon = 1
var arrows = 10
var spells = ["firebolt","speed buff"]
var currentSpell = 0
var manaRegenTimer
var spellDisplay
var buffDisplay
var currentBuffs = []
var level
var camera
#var playerSize = 1
var playerRect
#var playerCenter
#var unitBlockVector = Vector2(1,1)
const collisionLen = .8
var lastMoveVector = Vector2(0,0)
var arrowDamage = 8
var arrowDDisplay
var magicPower = 1
var animations = ["faceForeward","faceUpward","faceLeft","faceRight","goForeward","goUpward","goLeft","goRight","bow","die"]
var spriteFlipped = false

func _ready():
	print("player ready function")
	level = get_parent()
	genSprite()
	#print("intial player coordinates are "+str(initialCoordinates))
	camera = PlayerCam.new()
	#print("dividing Vector2(400, 900) by 2 = " + str(Vector2(400,900)/2))
	sprite.add_child(camera)
	var uic = get_node("../uiContainer")
	var uib = uic.get_child(0)
	uib.rect_position = Vector2(get_viewport().size[0]/2 - uib.rect_size[0]/2,30)
#	sprite = spriteScene.instance()
#	sprite.set_z_index(5)
#	get_parent().add_child(sprite)
#	print("charSprite should have been generated")
	healthBar = uic.get_node("uiBackground1/healthBar")
	#healthBar = uic.get_node("bowDrawBG/healthBar2")
	manaBar = uic.get_node("uiBackground1/manaBar")
	moneyDisplay = uic.get_node("uiBackground1/moneyDisplay")
	keyDisplay = uic.get_node("uiBackground1/keyDisplay")
	keyDisplay.set_text("Keys:\n"+str(keys))
	arrowDisplay = uic.get_node("uiBackground1/arrowDisplay")
	arrowDisplay.set_text("Arrows:\n"+str(arrows))
	arrowDDisplay = uic.get_node("bowDrawBG/bowDrawBar")
	arrowDDisplay.set_min(8)
	arrowDDisplay.set_max(20)
	arrowDDisplay.set_value(8)
	weaponDisplay = uic.get_node("uiBackground1/weaponDisplay")
	spellDisplay = uic.get_node("uiBackground1/spellDisplay")
	buffDisplay = uic.get_node("uiBackground1/buffDisplay")
	manaRegenTimer = Timer.new()
	manaRegenTimer.connect("timeout", self, "regenMana")
	add_child(manaRegenTimer)
	manaRegenTimer.start(1.0/2)
	

func _init(spawnCoordinates, h = 100, aM = 1):
	name = "Player"
	coordinates = spawnCoordinates
	playerRect = Rect2(coordinates, Vector2(1,1))
	screenCoordinates = spawnCoordinates*16+Vector2(8,8)
	initialCoordinates = spawnCoordinates
	health = h
	atkM = aM
	totalDamage = atkS * atkM
	print("Player has been initiated")

func removeBuff(buffName):
	currentBuffs.erase(buffName)
	if currentBuffs.has(buffName):
		return
	var buffText = buffDisplay.text
	match buffName:
		"atkSpeedUp":
			var loc = buffText.find(" Attack Speed Up")
			buffText.erase(loc, 17)
			if currentBuffs.size() > 1:
				buffText.erase(1,loc)
	if currentBuffs.size() == 1:
		buffText.erase(1,buffText.find(","))
	#buffText = "Currently Active Buffs:" + buffText
	buffDisplay.set_text(buffText)

func addBuff(buffName):
	if currentBuffs.has(buffName):
		currentBuffs.append(buffName)
		return
	currentBuffs.append(buffName)
	var buffText = buffDisplay.text
	match buffName:
		"atkSpeedUp":
			if currentBuffs.size() > 1:
				buffText += ","
			buffText += " Attack Speed Up"
	buffDisplay.set_text(buffText)

func genSprite():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	for an in animations:
		frames.add_animation(an)
		frames.set_animation_loop(an,true)
	frames.set_animation_loop("bow",false)
	frames.set_animation_loop("die",false)
	frames.add_frame("bow",grabber.grab(3))
	for x in range(9,14):
		frames.add_frame("die",grabber.grab(x))
	for x in range(7):
		frames.add_frame(animations[x],grabber.grab((x%4)+14))
	for x in range(31,31+6):
		frames.add_frame(animations[7],grabber.grab(x))
	sprite = AnimatedSprite.new()
	sprite.set_sprite_frames(frames)
	sprite.set_position(screenCoordinates)
	sprite.set_z_index(5)
	#sprite.set_scale(Vector2(2,2))
	sprite.play("faceForeward")
	level.add_child(sprite)
	print("charSprite should have been generated")

func regenMana():
	if mana < 100:
		mana += 1
		manaBar.value = mana

func unlockSpell(spellName):
	spells.append(spellName)

func changeMoney(a):
	money += a
	moneyDisplay.set_text("Money:\n"+str(money))

func setAttacking(b):
	isAttacking = b

func takeDamage(d):
	if isDead == true:
		return
	health -= d
	healthBar.set_value(health)
	if health > 100:
		health = 100
	if health <= 0:
#		var deathTimer = Timer.new()
		isDead = true
#		deathTimer.set_one_shot(true)
#		deathTimer.connect("timeout",self,"die")
#		add_child(deathTimer)
#		deathTimer.start(3)
#		var deathAnimTimer = Timer.new()
#		deathAnimTimer.connect("timeout",self,"deathAnimation")
#		deathAnimTimer.set_name("playerDeathAnimationTimer")
#		add_child(deathAnimTimer)
#		deathAnimTimer.start(.8)
#		deathAnimation()
		die()


#testcomment
func deathAnimation():
#	sprite.set_texture(load("res://sprites/charDeath"+str(deathAnimationFrame+1)+".tres"))
#	if deathAnimationFrame < 3:
#		deathAnimationFrame += 1
#	else:
#		get_node("playerDeathAnimationTimer").stop()
	sprite.play("die")

func die():
	deathAnimation()
	level.die()

func changeKeys(a):
	keys += a
	keyDisplay.set_text("Keys:\n"+str(keys))

func attackTimer(t):
	isAttacking = true
	var timer = Timer.new()
	timer.set_one_shot(true)
	add_child(timer)
	timer.connect("timeout", self, "attackTimerTimeOut")
	var time = float(t)/attackSpeed
	#print("Starting attack timer with "+String(time)+" seconds")
	timer.start(time)

func attack(vin = Vector2(0,0)):
	if isAttacking:
		return
	match weapons[currentWeapon]:
		"sword":
#			if attackTimer(1) == false:
#				return
#			sprite.set_texture(load("res://sprites/attackingSwordSprite.tres"))
#			var monsterCoords = []
#			for monster in level.monsters:
#				monsterCoords.append(monster.coordinates)
#			if monsterCoords.has(coordinates):
##				var hit = level.hitMonster(coordinates,float(totalDamage)/2,"melee")
#				print("dealt "+str(float(totalDamage)/2)+" damage to monster at " +str(coordinates))
#				return
#			if monsterCoords.has(coordinates+facing):
##				var hit = level.hitMonster(coordinates+facing,totalDamage,"melee")
#				print("dealt "+str(totalDamage)+" damage to monster at " +str(coordinates))
			pass
		"bow":
			if arrows == 0:
				return
			if vin == Vector2(0,0):
				drawBow()
				bowDrawn = true
				return
			if bowDrawn == false:
				return
			bowDrawn = false
			bowDrawTimer.stop()
			bowDrawTimer.queue_free()
			fireArrow(vin)
			changeArrows(-1)
			arrowDamage = 8
			arrowDDisplay.set_value(arrowDamage)
			attackTimer(1)

var bowDrawn
var bowDrawTimer

func incBowDamage():
	if arrowDamage < 20:
		arrowDamage += 1
		arrowDDisplay.value = arrowDamage

func drawBow():
	sprite.play("bow")
	bowDrawTimer = Timer.new()
	bowDrawTimer.connect("timeout", self, "incBowDamage")
	add_child(bowDrawTimer)
	bowDrawTimer.start(.2)

func fireArrow(vin):
	var arrow = Arrow.new(screenCoordinates + vin* 5, vin, level.projectiles.size(),arrowDamage, lastMoveVector)
	level.add_child(arrow)

func changeArrows(a):
	arrows += a
	arrowDisplay.set_text("Arrows:\n"+str(arrows))

func attackTimerTimeOut():
	isAttacking = false
	stopMoving()

func openChest(point):
	var chest =level.chests[point]
	if (chest[1]):
		return
	chest[1] = true
	level.updateChest(point)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	match chest[0]:
		LOOT.ARROW:
			changeArrows(1)
		LOOT.GELD:
			changeMoney(rng.randi_range(1,5))

var moveVector
var ec
var pv
var pc
var moving = false

func stopMoving():
	lastMoveVector = Vector2(0,0)
	moving = false
	sprite.play(animations[0])
	if (abs(facing.angle_to(Vector2(0,-1))) <= PI/4):
		sprite.play(animations[0])
	elif(abs(facing.angle_to(Vector2(0,1))) <= PI/4):
		sprite.play(animations[1])
	elif(abs(facing.angle_to(Vector2(-1,0))) <= PI/4):
		sprite.play(animations[2])
	elif(abs(facing.angle_to(Vector2(1,0))) <= PI/4):
		sprite.play(animations[3])

func move(vec,d):
	moveVector = vec*Vector2(d,d)*5
	pc = coordinates+Vector2(.5,.5)
	if vec[0] and vec[1]:
		ec = pc+Vector2(vec[0],0).normalized()*.5
		#print(str(Vector2(vec[0],0).normalized()*.5))
		pv = Vector2(0,.5)
		#print(str(pv))
		#level.setPointsForDrawLine(pc,ec)
		var mvp = (ec+pv*collisionLen+moveVector).floor()
		var mvn = (ec-pv*collisionLen+moveVector).floor()
		match level.levelGrid[mvp]:
			-1:
				moveVector[0] = 0
			TILE.WALL:
				moveVector[0] = 0
			TILE.CHEST:
				openChest(mvp)
				level.levelGrid[mvp] = TILE.CHESTOPEN
			TILE.DOOR:
				if level.doors[mvp]:
					continue
				if keys > 0:
					level.openDoor(mvp)
					changeKeys(-1)
					continue
				moveVector[0] = 0
		match level.levelGrid[mvn]:
			-1:
				moveVector[0] = 0
			TILE.WALL:
				moveVector[0] = 0
			TILE.CHEST:
				openChest(mvn)
				level.levelGrid[mvn] = TILE.CHESTOPEN
			TILE.DOOR:
				if level.doors[mvn]:
					continue
				if keys > 0:
					level.openDoor(mvn)
					changeKeys(-1)
					continue
				moveVector[0] = 0
		ec = pc+Vector2(0,vec[1]).normalized()*.5
		pv = Vector2(.5,0)
		mvp = (ec+pv*collisionLen+moveVector).floor()
		mvn = (ec-pv*collisionLen+moveVector).floor()
		match level.levelGrid[mvp]:
			-1:
				moveVector[1] = 0
			TILE.WALL:
				moveVector[1] = 0
			TILE.CHEST:
				openChest(mvp)
				level.levelGrid[mvp] = TILE.CHESTOPEN
			TILE.DOOR:
				if level.doors[mvp]:
					continue
				if keys > 0:
					level.openDoor(mvp)
					changeKeys(-1)
					continue
				moveVector[1] = 0
		match level.levelGrid[mvn]:
			-1:
				moveVector[1] = 0
			TILE.WALL:
				moveVector[1] = 0
			TILE.CHEST:
				openChest(mvn)
				level.levelGrid[mvn] = TILE.CHESTOPEN
			TILE.DOOR:
				if level.doors[mvn]:
					continue
				if keys > 0:
					level.openDoor(mvn)
					changeKeys(-1)
					continue
				moveVector[1] = 0
	else:
		ec = pc+vec*.5
		pv = Vector2(vec[1],vec[0])*.5
		var mvp = (ec+pv*collisionLen+moveVector).floor()
		var mvn = (ec-pv*collisionLen+moveVector).floor()
		match level.levelGrid[mvp]:
			-1:
				return
			TILE.WALL:
				return
			TILE.CHEST:
				openChest(mvp)
				level.levelGrid[mvp] = TILE.CHESTOPEN
			TILE.DOOR:
				if level.doors[mvp]:
					continue
				if keys > 0:
					level.openDoor(mvp)
					changeKeys(-1)
					continue
				return
		match level.levelGrid[mvn]:
			-1:
				return
			TILE.WALL:
				return
			TILE.CHEST:
				openChest(mvn)
				level.levelGrid[mvn] = TILE.CHESTOPEN
			TILE.DOOR:
				if level.doors[mvn]:
					continue
				if keys > 0:
					level.openDoor(mvn)
					changeKeys(-1)
					continue
				return
	coordinates += moveVector
	playerRect.position = coordinates
	screenCoordinates = coordinates*16+Vector2(8,8)
	sprite.set_position(screenCoordinates)
	facing = vec
	if !(sign(lastMoveVector[0]) == sign(moveVector[0]) and sign(lastMoveVector[1]) == sign(moveVector[1])) or moving == false or bowDrawn:
		if (abs(facing.angle_to(Vector2(0,1))) <= PI/4):
			sprite.play(animations[4])
			sprite.set_flip_h(false)
		elif(abs(facing.angle_to(Vector2(0,-1))) <= PI/4):
			sprite.play(animations[5])
			sprite.set_flip_h(false)
		elif(abs(facing.angle_to(Vector2(-1,0))) <= PI/4):
			sprite.play(animations[7])
			sprite.set_flip_h(true)
			spriteFlipped = true
		elif(abs(facing.angle_to(Vector2(1,0))) <= PI/4):
			sprite.play(animations[7])
			sprite.set_flip_h(false)
	#camera.align()
	moving = true
	lastMoveVector = moveVector

func castSpell(vin):
	if isAttacking == true:
		return
	#sprite.set_texture(load("res://sprites/charSprite.png"))
	if mana == 0:
		return
#	var spell
	match spells[currentSpell]:
		"firebolt":
			attackTimer(.5)
			if mana < 10:
				return
			#spell = FireBolt.new(coordinates, facing)
			level.add_child(FireBolt.new(screenCoordinates + vin* 5, vin, level.projectiles.size(), 5 * magicPower))
			mana -= 10
			manaBar.value = mana
		"speed buff":
			attackTimer(1)
			if mana < 50:
				return
			mana -= 50
			attackSpeed *= 4
			#print("attackSpeed is"+String(attackSpeed))
			var timer = Timer.new()
			timer.connect("timeout", self, "speedBuffTimeout")
			timer.set_one_shot(true)
			add_child(timer)
			timer.start(10)
			addBuff("atkSpeedUp")

func speedBuffTimeout():
	attackSpeed /= 4
	removeBuff("atkSpeedUp")

func changeWeapon(d):
	currentWeapon += d
	if currentWeapon == -1:
		currentWeapon = weapons.size()-1
	if currentWeapon == weapons.size():
		currentWeapon = 0
	weaponDisplay.set_text("Current Weapon:\n"+weapons[currentWeapon].capitalize())

func changeSpell(d):
	currentSpell += d
	if currentSpell == -1:
		currentSpell = spells.size()-1
	if currentSpell == spells.size():
		currentSpell = 0
	spellDisplay.set_text("Current Spell:\n"+spells[currentSpell].capitalize())
