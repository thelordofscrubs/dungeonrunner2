extends Projectile
class_name FireBolt

func _init(a,b,c,e).(a,b,c,60,e):
	pass

func checkForTerrain():
	match level.levelGrid[(coordinates/16).floor()]:
		0:
			queue_free()
		2:
			queue_free()

func _ready():
	._ready()
	texture = load("res://sprites/redSpellSprite.png")
