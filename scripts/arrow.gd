extends Projectile
class_name Arrow

func _init(a,b,c).(a,b,c,60):
	pass

func checkForTerrain():
	.checkForTerrain()
	#additional code

func _ready():
	._ready()
	texture = load("res://sprites/arrowSprite.png")
