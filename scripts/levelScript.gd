extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = Player.new(Vector2(0,0))

func fireProjTest(vin):
	add_child(FireBolt.new(vin, Vector2(1,0), Vector2(5,5)))
	print("fired projectile")


func _input(event):
	if event is InputEventMouseButton:
		fireProjTest(event.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
