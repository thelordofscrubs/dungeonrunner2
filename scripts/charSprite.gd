extends Sprite

func setCoords(c):
	set_position(c)

func _ready():
	set_centered(true)
	print("char sprite position :"+str(get_position()))