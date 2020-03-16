extends TextureProgress
class_name MonsterHealthBar

#var coords = Vector2(1,1)
var offset = Vector2(0,0)

func _ready():
	rect_scale = Vector2(2.5/16,1.2/16)
	offset = Vector2((-get_size()[0]-83)/32,20)
	rect_position += offset

func _init(maxV, cv):
	max_value = maxV
	value = cv
	texture_under = preload("res://otherArt/healthBarBackground.png")
	texture_progress = preload("res://otherArt/healthBarForeground.png")
