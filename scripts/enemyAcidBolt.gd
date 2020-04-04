extends Projectile
class_name EnemyAcidBolt

func _init(a,b,c,e).(a,b,c,20,e):
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
	var frames = SpriteFrames.new()
	frames.add_frame("default",grabber.grab(0))
	frames.add_frame("default",grabber.grab(1))
	set_sprite_frames(frames)
