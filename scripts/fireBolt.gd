extends Projectile
class_name FireBolt

func _init(a,b,c).(a,b,c,30):
	pass

func _ready():
	._ready()
	timer = Timer.new()
	timer.connect("timeout",self,"movePixel1")
	add_child(timer)
	timer.start(1.0/80)
	texture = load("res://sprites/redSpellSprite.png")
	scale = Vector2(1,1)
	z_index = 50
	match direction:
		Vector2(0,-1):
			pass
		Vector2(0,1):
			flip_v = true
		Vector2(1,0):
			texture = load("res://sprites/redSpellSpriteSide.png")
		Vector2(-1,0):
			texture = load("res://sprites/redSpellSpriteSide.png")
			flip_h = true

func movePixel1():
	position += direction
	moveCounter1 += 1
	if moveCounter1 == 3:
		timer.stop()
		var timer1 = Timer.new()
		timer1.connect("timeout",self,"movePixel")
		add_child(timer1)
		timer1.start(1.0/30)
		coordinates += direction


func movePixel():
	moveCounter += 1
	position += direction*Vector2(2,2)
#	if moveCounter == 8:
#		moveCounter = 0
#		coordinates += direction
#		match levelMap[coordinates]:
#			"wall":
#				get_parent().remove_child(self)
#				queue_free()
#				return
#			"door":
#				get_parent().remove_child(self)
#				queue_free()
#				return
#	if get_node("../..").hitMonster(coordinates,5,"fire") == 1:
#			get_parent().remove_child(self)
#			queue_free()

