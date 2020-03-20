extends Projectile
class_name Arrow

func _init(a,b,c,e,d).(a,b,c,120,e,d):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		TILE.OOB:
			queue_free()
		TILE.WALL:
#			timer.stop()
#			timer.queue_free()
			stopAllMotion = true
			timer = Timer.new()
			timer.set_one_shot(true)
			timer.connect("timeout", self, "queue_free")
			add_child(timer)
			timer.start(1)

func entityCollision():
	for monster in level.monsters:
		if Rect2(monster.coordinates,Vector2(1,1)).has_point(coordinates/16):
			monster.changeHealth(-damage)
			queue_free()
			return
	#if Rect2(level.player.coordinates,Vector2(1,1)).has_point(coordinates/16):
		#queue_free()
		#return

func _ready():
#	._ready()
	texture = load("res://sprites/arrowSprite.png")
