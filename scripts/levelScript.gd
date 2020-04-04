extends TileMap
class_name LevelNode


enum TILE{FLOOR,WALL,FINISH,DOOR,CHEST,CHESTOPEN,CHARSPRITE,BLUESLIME,KEY,POT,BATSKELETON,DOOROPEN,BLUESLIMESIDE, OOB = -1}
enum DIR{F,R,B,L,FR,BR,BL,FL}
enum MONST{BLUESLIME,BATSKELE,ENT,WEARWOLF,GARBAGE,PINKSLIME}
enum LOOT{ARROW,GELD}
enum POTLOOT{COINX2}
enum DAMAGETYPE{PHYSICAL,MAGICAL}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var levelID
var levelTileMap
var levelDimensions
var initPlayerCoords
var currentPlayerCoordinates
var chests = {}
var levelGrid = {}
var doors = {}
var projectiles = []
var monsters = []
var pots = {}
var coins = []
var uiTheme
var spriteAtlas = preload("res://sprites/spriteAtlas.png")
var debugMenuOpen = false
var debugMenu

# Called when the node enters the scene tree for the first time.
#func _ready():
#	uiTheme = Theme.new()
#	for c in get_node("uiContainer").get_children():
#		c.set_theme(uiTheme)

func darken(a):
	for c in get_node("uiContainer").get_children():
		c.set_modulate(Color(a,a,a,1))
	set_modulate(Color(a,a,a,1))

#func fireProjTest(vin):
#	projectiles.append(Arrow.new(player.screenCoordinates + vin* 20, vin, projectiles.size()))
#	add_child(projectiles[-1])
	#print("fired projectile")

func startLevel(id):
	print("id:"+str(id))
	levelID = int(id)
	name = "currentLevelNode"
	set_pause_mode(1)
	var levelName = "res://maps/map"+str(levelID)+"TileMap.tscn"
	print(levelName)
	levelTileMap = load(levelName).instance()
	var x
	var y
	var i = 0
	while x != -1:
		x = levelTileMap.get_cell(i,0)
		i += 1
	x = i-1
	i = 0
	while y != -1:
		y = levelTileMap.get_cell(0,i)
		i += 1
	y = i-1
	levelDimensions = Vector2(x,y)
	print("level dimensions are"+str(levelDimensions))
	### NEW X AND Y FROM HERE ###
	for y in range(levelDimensions[1]):
		for x in range(levelDimensions[0]):
			if levelTileMap.get_cell(x,y) == 6:
				initPlayerCoords = Vector2(x,y)#need player coordinates for spawning sprites in correct locations
				currentPlayerCoordinates = initPlayerCoords
	player = Player.new(initPlayerCoords)
	add_child(player)
	var tc
	for y in range(levelDimensions[1]):
		for x in range(levelDimensions[0]):
			var cc = Vector2(x,y)
			tc = levelTileMap.get_cell(x,y)
			set_cellv(cc, tc)
			match tc:
				-1:
					levelGrid[cc] = TILE.OOB
				0:
					levelGrid[cc] = TILE.FLOOR
				1:
					levelGrid[cc] = TILE.WALL
				2:
					levelGrid[cc] = TILE.FINISH
				3:
					levelGrid[cc] = TILE.DOOR
					doors[cc] = false
				4:
					levelGrid[cc] = TILE.CHEST
					spawnChest(LOOT.ARROW,cc)
				5:
					levelGrid[cc] = TILE.CHEST
				6: #playerSpawn
					levelGrid[cc] = TILE.FLOOR
					initPlayerCoords = cc
					set_cellv(cc,0)
				7: #blueSlimeSpawn
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(0,-1)
					var monster = buildingAMonster(MONST.BLUESLIME,cc,facing)
					addMonster(monster)
					#spawnMonster("blueSlime",cc,initPlayerCoords,facing)
					set_cellv(cc,0)
				8: #keySpawn
					levelGrid[cc] = TILE.KEY
					#spawnKey(cc)
					set_cellv(cc,0)
				9: #potSpawn
					levelGrid[cc] = TILE.POT
					spawnPot(cc)
					set_cellv(cc,0)
				10: #batSkeletonSpawn
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(0,-1)
					var monster = buildingAMonster(MONST.BATSKELE,cc,facing)
					addMonster(monster)
					#spawnMonster("batSkeleton",cc,initPlayerCoords,facing)
					set_cellv(cc,0)
				12:
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(1,0)
					var monster = buildingAMonster(MONST.BLUESLIME,cc,facing)
					addMonster(monster)
					#spawnMonster("blueSlime",cc,initPlayerCoords,facing)
					set_cellv(cc,0)
				13:
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(0,-1)
					var monster = buildingAMonster(MONST.GARBAGE,cc,facing)
					addMonster(monster)
					set_cellv(cc,0)
	for monster in monsters:
		monster.getMap(levelGrid)
	print("initial player coordinates are: "+str(initPlayerCoords[0])+", "+str(initPlayerCoords[1]))

func openDoor(vecC):
	doors[vecC] = true
	set_cellv(vecC, TILE.DOOROPEN)
	levelGrid[vecC] = TILE.DOOROPEN

func spawnPot(cc):
	pots[cc] = Pot.new(cc, POTLOOT.COINX2)
	add_child(pots[cc])

func breakPot(cc):
	pots.erase(cc)
	generateCoin(cc, 2)

func getCoin(c):
	player.changeMoney(c.value)
	coins.erase(c)
	c.queue_free()

func generateCoin(cc, v):
	var newCoin = Coin.new(cc,v)
	coins.append(newCoin)
	add_child(newCoin)


func moveMonsters(delta):
	for monster in monsters:
		monster.attemptMove(delta)

func addMonster(monster):
	monsters.append(monster)
	add_child(monster)

func buildingAMonster(monst, cc, facing):
	match monst:
		MONST.BLUESLIME:
			return BlueSlime.new(monsters.size(),player,cc,facing)
		MONST.BATSKELE:
			return BatSkeleton.new(monsters.size(),player,cc,facing)
		MONST.GARBAGE:
			return GarbageMonster.new(monsters.size(),player,cc,facing)

func spawnChest(loot, cc):
	chests[cc] = [loot,false]

func updateChest(cc):
	if (chests[cc][1]):
		set_cellv(cc,5)

var dv1 = Vector2(1,1)
var dv2 = Vector2(10,11)

var drawClass

func setPointsForDrawLine(v1,v2):
	if drawClass:
		drawClass.setPoints(v1,v2)
		return
	drawClass = drawingStuff.new(v1,v2)
	add_child(drawClass)

class drawingStuff:
	extends Node2D
	var v1
	var v2
	func _init(tv1,tv2):
		v1 = tv1*16
		v2 = tv2*16
		z_index = 100
		print("drawClass has been initiated")
	
	func setPoints(tv1,tv2):
		v1 = tv1*16
		v2 = tv2*16
		update()
	
	func _draw():
		#print("drawClass is printing")
		draw_line(v1,v2,Color(0,250,250), 1.3)

func die():
	get_parent().die()

func movePlayer(dir, delta):
	match dir:
		DIR.F:
			#print("level script is calling player.move((0,-1),"+str(delta)+")F")
			player.move(Vector2(0,-1), delta)
		DIR.R:
			#print("level script is calling player.move((1,0),"+str(delta)+")R")
			player.move(Vector2(1,0), delta)
		DIR.B:
			#print("level script is calling player.move((0,1),"+str(delta)+")B")
			player.move(Vector2(0,1), delta)
		DIR.L:
			#print("level script is calling player.move((-1,0),"+str(delta)+")L")
			player.move(Vector2(-1,0), delta)
		DIR.FR:
			#print("level script is calling player.move((-1,0),"+str(delta)+")L")
			player.move(Vector2(1,-1).normalized(), delta)
		DIR.BR:
			#print("level script is calling player.move((-1,0),"+str(delta)+")L")
			player.move(Vector2(1,1).normalized(), delta)
		DIR.BL:
			#print("level script is calling player.move((-1,0),"+str(delta)+")L")
			player.move(Vector2(-1,1).normalized(), delta)
		DIR.FL:
			#print("level script is calling player.move((-1,0),"+str(delta)+")L")
			player.move(Vector2(-1,-1).normalized(), delta)

var p
var ws

func _input(event):
	if debugMenuOpen:
		return
	if event is InputEventMouseButton and event.pressed == true and event.button_index == 1:
		player.drawBow()
	if event is InputEventMouseButton and event.pressed == false and event.button_index == 1:
		ws = get_viewport_rect().size
		p = event.position/2
		p -= ws/4#+initPlayerCoords
		p = p.normalized()
		player.attack(p)
	if event is InputEventMouseButton and event.pressed == false and event.button_index == 2:
		ws = get_viewport_rect().size
		p = event.position/2
		p -= ws/4#+initPlayerCoords
		p = p.normalized()
		player.castSpell(p)
	
func toggleDebug():
	if debugMenuOpen:
		closeDebug()
	else:
		openDebug()

func closeDebug():
	debugMenu.queue_free()
	debugMenuOpen = false		

func openDebug():
	debugMenu = DebugMenu.new()
	get_parent().add_child(debugMenu)
	debugMenuOpen = true

func debugCommand(commandString):
	match commandString:
		"godMode":
			player.toggleGodMode()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveMonsters(delta)
	if Input.is_action_just_pressed("debug"):
		toggleDebug()
	if debugMenuOpen:
		return
	if Input.is_action_just_released("chgw"):
		player.changeWeapon(1)
	if Input.is_action_pressed("forw") and Input.is_action_pressed("left"):
		movePlayer(7,delta)
		return
	if Input.is_action_pressed("back") and Input.is_action_pressed("left"):
		movePlayer(6,delta)
		return
	if Input.is_action_pressed("back") and Input.is_action_pressed("right"):
		movePlayer(5,delta)
		return
	if Input.is_action_pressed("forw") and Input.is_action_pressed("right"):
		movePlayer(4,delta)
		return
	if Input.is_action_pressed("forw"):
		movePlayer(0,delta)
		return
	if Input.is_action_pressed("back"):
		movePlayer(2,delta)
		return
	if Input.is_action_pressed("left"):
		movePlayer(3,delta)
		return
	if Input.is_action_pressed("right"):
		movePlayer(1,delta)
		return
	if (player.moving):
		player.stopMoving()
