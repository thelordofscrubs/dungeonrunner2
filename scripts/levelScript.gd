extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = Player.new(Vector2(50,50))
	add_child(player)

func fireProjTest(vin):
	add_child(FireBolt.new(vin, Vector2(1,0), Vector2(5,5)))
	print("fired projectile")

var p

func _input(event):
	if event is InputEventMouseButton:
		p = event.position
		if p[0] < 1920/2:
			p[0] *= .75
		else:
			p[0] *= 1.25
		if p[1] < 1080/2:
			p[1] *= .75
		else:
			p[1] *= 1.25
		fireProjTest(p)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
