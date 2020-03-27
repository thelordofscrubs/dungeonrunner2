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
	print("Arrow CFP function")
func _ready():
	var grabber = AtlasHandler.new()
	texture = grabber.grab(2)
