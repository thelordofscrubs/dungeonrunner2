extends "res://scripts/healthBar.gd"
class_name MonsterHealthBar

var coords = Vector2(1,1)
var offset = Vector2(200,50)

func _ready():
	rect_position += offset
	self.rect_size = Vector2(217,27)
	self.rect_scale = Vector2(.15,.07)

func _init(maxV, cv):
	max_value = maxV
	value = cv
	texture_under = preload("res://otherArt/healthBarBackground.png")
	texture_progress = preload("res://otherArt/healthBarForeground.png")
