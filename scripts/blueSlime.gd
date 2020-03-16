extends Monster
class_name BlueSlime

func _init(a,b,c,f).(a,b,c,f,10.0,10,5):
	pass

var spriteScene = preload("res://sprites/blueSlimeSprite.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	initSprite(spriteScene)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(.5)
	._ready()

var moveVector
var ec
var pv
var moveChecks = []

#enum TILE{OOB,FLOOR,WALL,FINISH,DOOR,CHEST,KEY,POT}
func attemptMove(delta):
	moveVector = facing*delta
	ec = coordinates+Vector2(.5,.5)+facing*.5
	pv = Vector2(facing[1],facing[0])*.5
	moveChecks[0] = (ec+pv*.9+moveVector).floor()
	moveChecks[1] = (ec-pv*.9+moveVector).floor()
	if !level.levelGrid.has(moveChecks[0]):
		facing *= -1
	if !level.levelGrid.has(moveChecks[1]):
		facing *= -1
	match level.levelGrid[moveChecks[0]]:
		-1:
			facing *= -1
		TILE.WALL:
			facing *= -1
	match level.levelGrid[moveChecks[1]]:
		-1:
			facing *= -1
		TILE.WALL:
			facing *= -1
	match facing:
		Vector2(1,0):
			move(moveVector)
		Vector2(0,1):
			move(moveVector)
		Vector2(-1,0):
			move(moveVector)
		Vector2(0,-1):
			move(moveVector)
	attack()

func attack():
	if playerCoordinates == coordinates:
		get_node("../Player").takeDamage(damage)
