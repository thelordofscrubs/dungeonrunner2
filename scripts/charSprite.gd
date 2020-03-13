extends Sprite

func setCoords(c):
	set_position(c)

func _ready():
	set_centered(true)
	print("char sprite position :"+str(get_position()))

func _draw():
	draw_rect(get_rect(),Color(255,0,0),false)
	#draw_texture(get_texture(),Vector2(8,8))