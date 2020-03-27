extends AnimatedSprite
class_name GroundItem

var coordinates
var spriteFrames = []
var rect


func _init(cc, spriteIndexStartEnd):
	coordinates = cc
	spriteFrames = spriteIndexStartEnd
	rect = Rect2(coordinates, Vector2(1,1))

func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	for x in range(spriteFrames[0],spriteFrames[1]+1):
		frames.add_frame("default",grabber.grab(x))
	frames.set_animation_loop("default",false)
	set_sprite_frames(frames)
	set_position(coordinates*16)
	set_centered(false)
	set_z_index(0)
	#print("pot generated at "+str(get_position()))
	
