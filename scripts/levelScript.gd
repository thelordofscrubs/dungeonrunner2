extends TileMap

enum DIR{F,R,B,L}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = Player.new(Vector2(50,50))
	add_child(player)

#func fireProjTest(vin):
#	add_child(FireBolt.new(vin, Vector2(1,0), Vector2(5,5)))
#	print("fired projectile")

func movePlayer(dir, delta):
	match dir:
		DIR.F:
			#print("level script is calling player.move((0,-1),"+str(delta)+")F")
			player.move(Vector2(0,-1), delta)
		DIR.R:
			#print("level script is calling player.move((1,0),"+str(delta)+")R")
			player.move(Vector2(1,0), delta)
		DIR.B:
			#print("level script is calling player.move((0,1),"+str(delta)+")B")
			player.move(Vector2(0,1), delta)
		DIR.L:
			#print("level script is calling player.move((-1,0),"+str(delta)+")L")
			player.move(Vector2(-1,0), delta)

var p
var ws

#func _input(event):
#	if event is InputEventMouseButton:
#		ws = OS.get_window_size()
#		p = event.position
##		if p[0] < ws[0]/2:
##			p[0] *= 1.25
##		else:
##			p[0] *= .75
##		if p[1] < ws[1]/2:
##			p[1] *= 1.25
##		else:
##			p[1] *= .75
#		p -= ws/2
#		p += player.coordinates
#		p[1]-=8
#		p[0]-=4
#		fireProjTest(p)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
