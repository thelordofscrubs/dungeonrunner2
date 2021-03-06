extends Monster
class_name BlueSlime
var moveVector
var ec
var pv
var moveChecks = [Vector2(0,0),Vector2(0,0)]

func _init(a,b,c,f).(a,b,c,f,10.0,10,5):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_animation("move")
	frames.add_animation("die")
	frames.add_frame("move",grabber.grab(6))
	set_sprite_frames(frames)
	play("move")
	set_centered(false)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(.5)

func flipFacing():
	match level.levelGrid[moveChecks[0]]:
		-1:
			return true
		TILE.WALL:
			return true
	match level.levelGrid[moveChecks[1]]:
		-1:
			return true
		TILE.WALL:
			return true

#enum TILE{OOB,FLOOR,WALL,FINISH,DOOR,CHEST,KEY,POT}
func attemptMove(delta):
	moveVector = facing*delta
	ec = coordinates+Vector2(.5,.5)+facing*.5
	pv = Vector2(facing[1],facing[0])*.5
	moveChecks[0] = (ec+pv*.9+moveVector).floor()
	moveChecks[1] = (ec-pv*.9+moveVector).floor()
	if flipFacing():
		facing *= -1
	moveVector = facing*delta
	move(moveVector)

func attack():
	if player.playerRect.intersects(entRect):
		player.takeDamage(damage)
