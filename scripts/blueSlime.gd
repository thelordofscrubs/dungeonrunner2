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
	
func attemptMove(delta):
#	var attemptedCoordinates = coordinates + facing
#	if levelMap[attemptedCoordinates] == "wall":
#		facing *= Vector2(-1,-1)
#		move(facing, delta)
#	elif levelMap[attemptedCoordinates] == "door":
#		facing *= Vector2(-1,-1)
#		move(facing, delta)
#	else:
	match facing:
		Vector2(1,0):
			move(facing, delta)
		Vector2(0,1):
			move(facing, delta)
		Vector2(-1,0):
			move(facing, delta)
		Vector2(0,-1):
			move(facing, delta)
	attack()

func attack():
	if playerCoordinates == coordinates:
		get_node("../Player").takeDamage(damage)
