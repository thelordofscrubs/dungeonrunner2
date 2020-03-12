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

func fireProjTest(vin):
	add_child(Arrow.new(player.coordinates + vin * 10, vin, Vector2(0,0)))

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

func _input(event):
	if event is InputEventMouseButton:
		ws = OS.get_window_size()
		p = event.position/2
		p -= ws/4
		p+= Vector2(40,40)
		p = p.normalized()
		fireProjTest(p)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
