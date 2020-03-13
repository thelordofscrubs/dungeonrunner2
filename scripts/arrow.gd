extends Projectile
class_name Arrow

func _init(a,b).(a,b,60):
	pass

func _ready():
	._ready()
	texture = load("res://sprites/arrowSprite.png")