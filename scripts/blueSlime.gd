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

#enum TILE{OOB,FLOOR,WALL,FINISH,DOOR,CHEST,KEY,POT}
func attemptMove(delta):
	var moveAmount = facing*delta
	var coordinates2 = coordinates
	for c in coordinates2:
		if (c > 0):
			c += 16
	if levelMap[(coordinates2+(facing*delta)).floor()] == TILE.WALL:
		facing *= -1
	match facing:
		Vector2(1,0):
			move(moveAmount)
		Vector2(0,1):
			move(moveAmount)
		Vector2(-1,0):
			move(moveAmount)
		Vector2(0,-1):
			move(moveAmount)
	attack()

func attack():
	if playerCoordinates == coordinates:
		get_node("../Player").takeDamage(damage)
