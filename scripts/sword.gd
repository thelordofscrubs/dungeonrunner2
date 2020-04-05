extends Projectile
class_name SwordProjectile

var timeAlive = 0.0
var player
var rect
var circlePos
var initCirclePos

func _init(a,b,c,e,d).(a,b,c,3,e,d):
	coordinates = Vector2(0,0)

func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_frame("default",grabber.grab(63))
	set_sprite_frames(frames)
	set_rotation(direction.angle()+PI*5/8)
	player = get_parent()
	circlePos = direction.angle()-PI/4
	initCirclePos = circlePos
	coordinates = Vector2(cos(circlePos), sin(circlePos))
	rect = Rect2(player.coordinates+coordinates, Vector2(0.75,0.75))
	set_scale(Vector2(0.75,0.75))

func invisibleBoi():
	startNormalMovement()

func updatePos(d):
	if abs(circlePos - initCirclePos) > PI/2:
		queue_free()
	circlePos += d*pixelPerSecond
	coordinates = Vector2(cos(circlePos), sin(circlePos))
	set_position(coordinates*16)
	entityCollision()
	set_rotation(circlePos+PI/2)
	rect.position = coordinates+player.coordinates

func entityCollision():
	for monster in level.monsters:
		if monster.entRect.intersects(rect):
			monster.getHit(damage, DAMAGETYPE.PHYSICAL)

func _process(delta):
	if !stopAllMotion:
		updatePos(delta)
