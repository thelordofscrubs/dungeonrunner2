extends Projectile
class_name FireBolt

func _init(a,b,c,e).(a,b,c,60,e):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		TILE.WALL,TILE.DOOR:
			queue_free()

func checkForPlayer():
	pass
func _ready():
	var grabber = AtlasHandler.new()
	texture = grabber.grab(30)