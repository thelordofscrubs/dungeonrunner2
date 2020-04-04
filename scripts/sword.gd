extends Projectile
class_name SwordProjectile

var timeAlive = 0.0
var player
var rect

func _init(a,b,c,e,d).(a,b,c,10,e,d):
	coordinates = Vector2(0,0)

func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_frame("default",grabber.grab(63))
	set_sprite_frames(frames)
	set_rotation(direction.angle()+PI*3/4)
	direction = direction.rotated(PI/4)
	player = get_parent()
	rect = Rect2(player.coordinates, Vector2(1,1))

func invisibleBoi():
	startNormalMovement()

func updatePos(d):
	if timeAlive > .4:
		queue_free()
	timeAlive += d
	coordinates += direction *d * pixelPerSecond
	set_position(coordinates*16)
	entityCollision()
	direction = direction.rotated(-5/4*PI*d*10)
	rotate(-PI*5/4*d)
	rect.position = coordinates+player.coordinates

func entityCollision():
	for monster in level.monsters:
		if monster.entRect.intersects(rect):
			monster.getHit(damage, DAMAGETYPE.PHYSICAL)

func _process(delta):
	if !stopAllMotion:
		updatePos(delta)
