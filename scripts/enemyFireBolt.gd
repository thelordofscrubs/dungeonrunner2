extends Projectile
class_name EnemyFireBolt

func _init(a,b,c,e).(a,b,c,60,e):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		TILE.WALL,TILE.DOOR:
			queue_free()

func entityCollision():
    checkForPlayer()

func checkForPlayer():
    if level.player.playerRect.has_point(coordinates/16):
        level.player.takeDamage(damage)
        queue_free()

func _ready():
	var grabber = AtlasHandler.new()
	texture = grabber.grab(30)