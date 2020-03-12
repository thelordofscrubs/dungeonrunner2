extends TileMap

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


# Called when the node enters the scene tree for the first time.
#func _ready():
	#player = Player.new(Vector2(50,50))
	#add_child(player)

func fireProjTest(vin):
	add_child(Arrow.new(player.coordinates + vin * 10, vin, Vector2(0,0)))
	print("fired projectile")

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
	print(str(levelDimensions))
	### NEW X AND Y FROM HERE ###
	for y in range(levelDimensions[1]):
		for x in range(levelDimensions[0]):
			if levelTileMap.get_cell(x,y) == 6:
				initPlayerCoords = Vector2(x,y)#need player coordinates for spawning sprites in correct locations
				currentPlayerCoordinates = initPlayerCoords
	for y in range(levelDimensions[1]):
		for x in range(levelDimensions[0]):
			var cc = Vector2(x,y)
			match levelTileMap.get_cell(x,y):
				-1:
					levelGrid[cc] = "oob"
				0:
					levelGrid[cc] = "floor"
				1:
					levelGrid[cc] = "wall"
				2:
					levelGrid[cc] = "finish"
				3:
					levelGrid[cc] = "door"
					doors[cc] = false
				4:
					levelGrid[cc] = "chest"
					#spawnChest("doubleArrow",cc)
				5:
					levelGrid[cc] = "chest"
				6: #playerSpawn
					levelGrid[cc] = "floor"
					levelTileMap.set_cellv(cc,0)
				7: #blueSlimeSpawn
					levelGrid[cc] = "floor"
					var facing = Vector2(0,-1)
					#spawnMonster("blueSlime",cc,initPlayerCoords,facing)
					levelTileMap.set_cellv(cc,0)
				8: #keySpawn
					levelGrid[cc] = "key"
					#spawnKey(cc)
					levelTileMap.set_cellv(cc,0)
				9: #potSpawn
					levelGrid[cc] = "pot"
					#spawnPot(cc)
					levelTileMap.set_cellv(cc,0)
				10: #batSkeletonSpawn
					levelGrid[cc] = "floor"
					var facing = Vector2(0,-1)
					#spawnMonster("batSkeleton",cc,initPlayerCoords,facing)
					levelTileMap.set_cellv(cc,0)
				12:
					levelGrid[cc] = "floor"
					var facing = Vector2(1,0)
					#spawnMonster("blueSlime",cc,initPlayerCoords,facing)
					levelTileMap.set_cellv(cc,0)
	print("initial player coordinates are: "+str(initPlayerCoords[0])+", "+str(initPlayerCoords[1]))
	levelTileMap.set_position(levelTileMap.get_position()-initPlayerCoords*Vector2(16,16))
	levelTileMap.set_z_index(0)
	player = Player.new(initPlayerCoords)
	add_child(player)
	player.genSprite()
#	graphicsContainerNode.add_child(levelTileMap)
	#get_node("healthBar").set_position()
#	graphicsContainerNode.set_position(OS.get_window_size()/Vector2(2,2)-Vector2(8,8))
#	for monster in monsters:
#		monster.getMap(levelGrid)

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
	if event is InputEventMouseButton:
		ws = OS.get_window_size()
		p = event.position/2
		p -= ws/4
		p+= Vector2(40,40)
		p = p.normalized()
		fireProjTest(p)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
