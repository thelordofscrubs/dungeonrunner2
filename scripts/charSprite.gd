extends Sprite

func setCoords(c):
	set_position(c)

func _ready():
	set_centered(false)
	print("char sprite position :"+str(get_position()))
