extends Sprite

func _ready():
	set_position(OS.get_window_size()/Vector2(2,2))
	set_centered(true)
	print("char sprite position :"+str(get_position()))