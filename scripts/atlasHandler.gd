extends Object
class_name AtlasHandler
var atlas = preload("res://sprites/spriteAtlas.png")
var w
func _init(tex = null):
	if (tex):
		atlas = tex
	w = atlas.get_width()/16

func grab(idx = 0, size = Vector2(16,16)):
	var text = AtlasTexture.new()
	text.set_atlas(atlas)
	text.set_region(Rect2(Vector2(idx%w * 16,floor(idx/w) * 16),size))
	return text
