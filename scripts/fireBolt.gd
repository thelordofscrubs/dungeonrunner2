extends Projectile
class_name FireBolt

func _init(a,b,c,e).(a,b,c,60,e):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		TILE.WALL,TILE.DOOR:
			queue_free()

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
	var grabber = AtlasHandler.new()
	texture = grabber.grab(30)