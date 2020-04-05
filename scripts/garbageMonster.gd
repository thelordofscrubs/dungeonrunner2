extends Monster
class_name GarbageMonster
var acidBoltTimer

func _init(id_, p, c, f).(id_, p, c, f, 100.0, 100, 30) :
	pass
func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_animation("move")
	frames.add_animation("die")
	frames.add_frame("move",grabber.grab(24))
	set_sprite_frames(frames)
	play("move")
	set_centered(false)
	acidBoltTimer = Timer.new()
	add_child(acidBoltTimer)
	acidBoltTimer.connect("timeout",self,"fireAcidBolt")
	acidBoltTimer.start(2)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(2)

func detectWall(moveChecks):
	for v in moveChecks:
		match level.levelGrid[v]:
			TILE.WALL:
				return true
			TILE.DOOR:
				return true

func attemptMove(delta):
	var moveVector = facing*delta
	var ec = coordinates+Vector2(.5,.5)+facing*.5
	var pv = Vector2(facing[1],facing[0])*.5
	var moveChecks = [Vector2(0,0),Vector2(0,0)]
	moveChecks[0] = (ec+pv*.9+moveVector).floor()
	moveChecks[1] = (ec-pv*.9+moveVector).floor()
	if detectWall(moveChecks):
		facing = facing.rotated(90*PI/180)#Convert to raidian 
	moveVector = facing*delta*.75
	move(moveVector)

func attack():
	if player.playerRect.intersects(entRect):
		player.takeDamage(damage)

func fireAcidBolt():
	level.add_child(EnemyAcidBolt.new(coordinates*16 + Vector2(8,8) + facing*5,facing,level.projectiles.size(),damage))
	level.add_child(EnemyAcidBolt.new(coordinates*16 + Vector2(8,8) + facing*5,facing.rotated(30*PI/180),level.projectiles.size(),damage))
	level.add_child(EnemyAcidBolt.new(coordinates*16 + Vector2(8,8) + facing*5,facing.rotated(-30*PI/180),level.projectiles.size(),damage))
