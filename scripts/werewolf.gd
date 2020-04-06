extends Monster
class_name Werewolf

func _init(a,b,c,f).(a,b,c,f,30.0,30,15):
	pass
	
func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_animation("move")
	frames.add_animation("attack")
	frames.add_frame("move",grabber.grab(37))
	frames.add_frame("attack",grabber.grab(38))
	set_sprite_frames(frames)
	play("move")
	set_centered(false)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(2)

func attemptMove(delta):
	if isPointInSight(coordinates,player.coordinates):
		facing = coordinates.direction_to(player.coordinates)
	else:
		facing = Vector2(0,0)
	var moveVector = facing*delta
	var ec = coordinates+Vector2(.5,.5)+facing*.5
	var pv = Vector2(facing[1],facing[0])*.5
	var moveChecks = [Vector2(0,0),Vector2(0,0)]
	moveChecks[0] = (ec+pv*.9+moveVector).floor()
	moveChecks[1] = (ec-pv*.9+moveVector).floor()
	if detectWall(moveChecks):
		return
	moveVector = facing*delta
	move(moveVector)

func detectWall(moveChecks):
	for v in moveChecks:
		match level.levelGrid[v]:
			TILE.WALL:
				return true
			TILE.DOOR:
				return true

func attack():
	if player.playerRect.intersects(entRect):
		player.takeDamage(damage)
	
