extends Monster
class_name BatSkeleton
func _init(a,b,c,f).(a,b,c,f,20.0,20,10):
	pass

var spriteScene = preload("res://sprites/batSkeletonSprite.tscn")
func _ready():
	sprite = spriteScene.instance()
	sprite.set_position((coordinates-playerCoordinates)*Vector2(16,16))
	get_node("../graphicsContainer/spriteContainer").add_child(sprite)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(.5)
	moveTimer = Timer.new()
	add_child(moveTimer)
	moveTimer.connect("timeout",self,"attemptMove")
	moveTimer.start(1)

func attemptMove():
	var attemptedCoordinates = coordinates + facing
	if levelMap[attemptedCoordinates] == "wall":
		facing *= Vector2(-1,-1)
		move(facing, 1)
	elif levelMap[attemptedCoordinates] == "door":
		facing *= Vector2(-1,-1)
		move(facing, 1)
	else:
		match facing:
			Vector2(1,0):
				move(facing, 1)
				facing = Vector2(0,1)
			Vector2(0,1):
				move(facing, 1)
				facing = Vector2(-1,0)
			Vector2(-1,0):
				move(facing, 1)
				facing = Vector2(0,-1)
			Vector2(0,-1):
				move(facing, 1)
				facing = Vector2(1,0)
	attack()

func attack():
	if playerCoordinates == coordinates:
		get_node("../Player").takeDamage(damage)
