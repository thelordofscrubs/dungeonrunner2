extends Projectile
class_name SwordProjectile

func _init(a,b,c,e,d).(a,b,c,100,e,d):
    pass

func _ready():
    var grabber = AtlasHandler.new()
    var frames = SpriteFrames.new()
    frames.add_frame("default",grabber.grab(63))
    set_sprite_frames(frames)
    rotate(-PI/2)
    direction.rotate(PI/4)

func invisibleBoi():
    startNormalMovement()

func updatePos(d):
    coordinates += direction *d * pixelPerSecond
    set_position(coordinates)
    entityCollision()
    direction.rotate(-PI/4*d)

func entityCollision():
    for monster in level.monsters:
        if monster.entRect.has_point(coordinates/16):
            monster.getHit(damage, DAMAGETYPE.PHYSICAL)
            queue_free()
            return

func _process(delta):
    if !stopAllMotion:
        updatePos(delta)