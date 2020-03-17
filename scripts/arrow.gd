extends Projectile
class_name Arrow

func _init(a,b,c,e,d).(a,b,c,100,e,d):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		0:
			queue_free()
		2:
#			timer.stop()
#			timer.queue_free()
			moveNorm = false
			timer = Timer.new()
			timer.set_one_shot(true)
			timer.connect("timeout", self, "queue_free")
			add_child(timer)
			timer.start(1)

func _ready():
#	._ready()
	texture = load("res://sprites/arrowSprite.png")
