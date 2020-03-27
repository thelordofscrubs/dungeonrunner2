extends Sprite
class_name Projectile

enum TILE{FLOOR,WALL,FINISH,DOOR,CHEST,CHESTOPEN,CHARSPRITE,BLUESLIME,KEY,POT,BATSKELETON,DOOROPEN,BLUESLIMESIDE, OOB = -1}

var coordinates
var direction
#var moveCounter = 0
var timer
var pixelPerSecond
#var moveCounter1 = 0
#var levelMap = {}
#var bounds
var projectileId
var oldmod = [0.0, 0.0]
var newmod = [0.0, 0.0]
var level
var damage
var moveNorm = false
var stopAllMotion = false
var atlas

func _ready():
	scale = Vector2(1,1)
	z_index = 50
	level = get_parent()
	atlas = level.spriteAtlas
	invisibleBoi()

func invisibleBoi():
	set_visible(false)
	var tempTimer = Timer.new()
	add_child(tempTimer)
	tempTimer.connect("timeout", self, "startNormalMovement")
	tempTimer.set_one_shot(true)
	tempTimer.start(.08)

func startNormalMovement():
	set_visible(true)
#	timer = Timer.new()
#	timer.connect("timeout", self, "updatePos")
#	add_child(timer)
#	timer.start(1.0/pixelPerSecond)
	moveNorm = true

func moveNoCollision(delta):
	coordinates += direction * delta * pixelPerSecond
	set_position(coordinates)
	#print(str(get_incoming_connections()))

func updatePos(d):
	coordinates += direction *d * pixelPerSecond
	set_position(coordinates)
	entityCollision()
#	print(str(bounds))
	if !level.levelGrid.has((coordinates/16.0).floor()):
		queue_free()
			#print("deleted arrow")
	if direction[0] > 0:
		newmod[0] = fmod(coordinates[0],16.0)
		if newmod[0] < oldmod[0]:
			#print("newmod[0] is smaller than oldmod[0], newmod = "+str(newmod[0])+" and oldmod = "+str(oldmod[0])+" and coordinates is currently" + str(coordinates))
			checkForTerrain()
		oldmod[0] = newmod[0]
	if direction[0] < 0:
		newmod[0] = fmod(coordinates[0],16.0)
		if newmod[0] > oldmod[0]:
			checkForTerrain()
		oldmod[0] = newmod[0]
	if direction[1] < 0:
		newmod[1] = fmod(coordinates[1],16.0)
		if newmod[1] > oldmod[1]:
			checkForTerrain()
		oldmod[1] = newmod[1]
	if direction[1] > 0:
		newmod[1] = fmod(coordinates[1],16.0)
		if newmod[1] < oldmod[1]:
			#print("newmod[1] is smaller than oldmod[1], newmod = "+str(newmod[1])+" and oldmod = "+str(oldmod[1])+" and coordinates is currently" + str(coordinates))
			checkForTerrain()
		oldmod[1] = newmod[1]

func entityCollision():
	for monster in level.monsters:
		if monster.entRect.has_point(coordinates/16):
			monster.changeHealth(-damage)
			queue_free()
			return
	for pot in level.pots:
		if pot.rect.has_point(coordinates/16):
			pot.hit()
			queue_free()
			return
	checkForPlayer()

func checkForPlayer():
	if level.player.playerRect.has_point(coordinates/16):
		queue_free()
		return

#func checkIfIn(vec2, rec2):
#	if vec2[0] > rec2.position[0] and vec2[0] < rec2.end[0] and vec2[1] > rec2.position[1] and vec2[1] < rec2.end[1]:
#		return true

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		TILE.WALL:
			queue_free()
		TILE.DOOR:
			queue_free()

#func _draw():
	#draw_rect(get_rect(),Color(0,255,0),false)
	#draw_texture(get_texture(),Vector2(0,0))

func _init(coords, dir, id, persec, d, pv = Vector2(0,0)):
	damage = d
	projectileId = id
	pixelPerSecond = persec
	#print("arrow Spawned at "+str(coords)+", going towards Vector2"+str(dir))
	#print("real position of player = "+str(pixelCoordinates))
	coordinates = coords
	oldmod[0] = fmod(coords[0], 16.0)
	oldmod[1] = fmod(coords[1], 16.0)
	position = (coords)
	direction = dir+pv*2
	set_centered(true)
	set_rotation(atan2(dir[1],dir[0])+ PI/2)

func _process(delta):
	if !stopAllMotion:
		if moveNorm:
			updatePos(delta)
		else:
			moveNoCollision(delta)



