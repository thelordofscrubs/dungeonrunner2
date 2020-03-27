extends Monster
class_name BatSkeleton

var moveVector
var ec
var pv
var moveChecks = [Vector2(0,0),Vector2(0,0)]
var timeAlive = 0

func _init(a,b,c,f).(a,b,c,f,20.0,20,10):
	pass

func _ready():
	flying = true
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(.5)
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_animation("move")
	frames.add_animation("die")
	frames.add_frame("move",grabber.grab(5))
	set_sprite_frames(frames)
	play("move")
	set_centered(false)

func attemptMove(delta):
	timeAlive += delta
	moveVector = facing*delta
	ec = coordinates+Vector2(.5,.5)+facing*.5
	pv = Vector2(facing[1],facing[0])*.5
	moveChecks[0] = (ec+pv*.9+moveVector).floor()
	moveChecks[1] = (ec-pv*.9+moveVector).floor()
	moveVector = facing*delta*2
	facing = facing.rotated(.03)
	if detectWall():
		return
	move(Vector2(moveVector[0]-cos(timeAlive*12)*.02,moveVector[1]+sin(timeAlive*12)*.02))

func detectWall():
	for v in moveChecks:
		match level.levelGrid[v]:
			TILE.WALL:
				return true
			TILE.DOOR:
				return true

func attack():
	pass
