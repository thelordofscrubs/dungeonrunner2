extends Monster
class_name GarbageMonster
var acidBoltTimer

func _init(id_, p, c, f,e).(id_, p, c, f, 100.0, 100, e) :
    pass
func _ready():
    var grabber = AtlasHandler.new()
    var frames = SpriteFrames.new()
    frames.add_animation("move")
    frames.add_animation("die")
    frames.add_frame("move",grabber.grab(22))
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
    attackTimer.start(.5)

func detectWall(moveChecks):
    for v in moveChecks:
       match level.levelGrid[v]:
            TILE.WALL:
                return true
            TILE.DOOR:
                return true

func attemptMove(delta):
    moveVector = facing*delta
	ec = coordinates+Vector2(.5,.5)+facing*.5
	pv = Vector2(facing[1],facing[0])*.5
	moveChecks[0] = (ec+pv*.9+moveVector).floor()
	moveChecks[1] = (ec-pv*.9+moveVector).floor()
    facing = facing.rotated(.03)
    moveVector = facing*delta*2
	if detectWall(moveChecks):
		return
    move(Vector2(moveVector))

func attack():
    if player.playerRect.intersects(entRect):
        player.takeDamage(damage)

func fireFireBolt():
    if !isPointInSight(coordinates, player.coordinates+Vector2(.5,.5)):
        return
    var dtp = coordinates.direction_to(player.coordinates+Vector2(.5,.5)+player.lastMoveVector.normalized())
    level.add_child(EnemyAcidBolt.new(coordinates*16 +dtp*3,dtp,level.projectiles.size(),damage))