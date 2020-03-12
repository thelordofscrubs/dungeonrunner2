extends Monster

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spriteScene = preload("res://sprites/blueSlimeSprite.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	flying = false
	health = 10.0
	maxHealth = 10
	sprite = spriteScene.instance()
	sprite.set_position((coordinates)*Vector2(16,16))
	get_node("../graphicsContainer/spriteContainer").add_child(sprite)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(.5)
	moveTimer = Timer.new()
	add_child(moveTimer)
	moveTimer.connect("timeout",self,"attemptMove")
	moveTimer.start(1)
	._ready()
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
