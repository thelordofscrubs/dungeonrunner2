extends Projectile
class_name Arrow

func _init(a,b,c,e,d).(a,b,c,120,e,d):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		TILE.OOB:
			queue_free()
		TILE.DOOR, TILE.WALL:
#			timer.stop()
#			timer.queue_free()
			stopAllMotion = true
			timer = Timer.new()
			timer.set_one_shot(true)
			timer.connect("timeout", self, "queue_free")
			add_child(timer)
			timer.start(1)

func checkForPlayer():
	pass

func entityCollision():
	for monster in level.monsters:
		if monster.entRect.has_point(coordinates/16):
			monster.getHit(damage, DAMAGETYPE.PHYSICAL)
			queue_free()
			return
	for pot in level.pots.values():
		if pot.rect.has_point(coordinates/16):
			pot.hit()
			queue_free()
			return
	checkForPlayer()

func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_frame("default",grabber.grab(2))
	set_sprite_frames(frames)
