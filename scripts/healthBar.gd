extends TextureProgress

func _init(v = 100):
	value = v
	rect_position = Vector2(get_viewport_rect().size[0]/2-208,-30)

#func changeValue(v):
#	set_value(v)
