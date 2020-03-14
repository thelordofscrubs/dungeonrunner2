extends TileMap

enum TILE{OOB,FLOOR,WALL,FINISH,DOOR,CHEST,KEY,POT}
enum DIR{F,R,B,L}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var levelID
var levelTileMap
var levelDimensions
var initPlayerCoords
var currentPlayerCoordinates
var levelGrid = {}
var doors = {}
var projectiles = []
var monsters = []


# Called when the node enters the scene tree for the first time.
#func _ready():
	#player = Player.new(Vector2(50,50))
	#add_child(player)

func fireProjTest(vin):
	projectiles.append(Arrow.new(player.screenCoordinates + vin* 20, vin, projectiles.size()))
	add_child(projectiles[-1])
	#print("fired projectile")

func startLevel(id):
	print("id:"+str(id))
	levelID = int(id)
	name = "level"+str(levelID)
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
					#spawnChest("doubleArrow",cc)
				5:
					levelGrid[cc] = TILE.CHEST
				6: #playerSpawn
					levelGrid[cc] = TILE.FLOOR
					initPlayerCoords = cc
					set_cellv(cc,0)
				7: #blueSlimeSpawn
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(0,-1)
					var monster = BlueSlime.new(monsters.size(),currentPlayerCoordinates,cc,facing)
					addMonster(monster)
					#spawnMonster("blueSlime",cc,initPlayerCoords,facing)
					set_cellv(cc,0)
				8: #keySpawn
					levelGrid[cc] = TILE.KEY
					#spawnKey(cc)
					set_cellv(cc,0)
				9: #potSpawn
					levelGrid[cc] = TILE.POT
					#spawnPot(cc)
					set_cellv(cc,0)
				10: #batSkeletonSpawn
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(0,-1)
					var monster = BatSkeleton.new(monsters.size(),currentPlayerCoordinates,cc,facing)
					addMonster(monster)
					#spawnMonster("batSkeleton",cc,initPlayerCoords,facing)
					set_cellv(cc,0)
				12:
					levelGrid[cc] = TILE.FLOOR
					var facing = Vector2(1,0)
					var monster = BlueSlime.new(monsters.size(),currentPlayerCoordinates,cc,facing)
					addMonster(monster)
					#spawnMonster("blueSlime",cc,initPlayerCoords,facing)
					set_cellv(cc,0)
	for monster in monsters:
		monster.getMap(levelGrid)
	print("initial player coordinates are: "+str(initPlayerCoords[0])+", "+str(initPlayerCoords[1]))
	player = Player.new(initPlayerCoords)
	add_child(player)
	#get_node("healthBar").set_position()
#	graphicsContainerNode.set_position(OS.get_window_size()/Vector2(2,2)-Vector2(8,8))
#	for monster in monsters:
#		monster.getMap(levelGrid)

func moveMonsters(delta):
	for monster in monsters:
		monster.attemptMove(delta)
	pass

func addMonster(monster):
	monsters.append(monster)
	add_child(monster)

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

var p
var ws

func _input(event):
	if event is InputEventMouseButton and event.pressed == true:
		ws = get_viewport_rect().size
		p = event.position/2
		p -= ws/4#+initPlayerCoords
		p = p.normalized()
		fireProjTest(p)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
