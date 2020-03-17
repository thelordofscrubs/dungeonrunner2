extends Monster
class_name BatSkeleton
func _init(a,b,c,f).(a,b,c,f,20.0,20,10):
	pass

var spriteScene = preload("res://sprites/batSkeletonSprite.tscn")
func _ready():
	initSprite(spriteScene)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(.5)

func attemptMove(delta):
	var attemptedCoordinates = coordinates + facing
	if levelMap[attemptedCoordinates] == TILE.WALL:
		facing *= Vector2(-1,-1)
		move(facing * delta)
	elif levelMap[attemptedCoordinates] == TILE.DOOR:
		facing *= Vector2(-1,-1)
		move(facing * delta)
	else:
		match facing:
			Vector2(1,0):
				move(facing * delta)
				facing = Vector2(0,1)
			Vector2(0,1):
				move(facing * delta)
				facing = Vector2(-1,0)
			Vector2(-1,0):
				move(facing * delta)
				facing = Vector2(0,-1)
			Vector2(0,-1):
				move(facing * delta)
				facing = Vector2(1,0)
	attack()

func attack():
	pass
