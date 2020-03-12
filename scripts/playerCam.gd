extends Camera2D
class_name PlayerCam

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var totalDelta = 0

func _init(c):
	set_position(c)

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_position()
	set_enable_follow_smoothing(true)
	set_zoom(Vector2(.5,.5))
	set_h_drag_enabled(false)
	set_v_drag_enabled(false)
	make_current()



func _process(delta):
	totalDelta += delta;
	if totalDelta > .01:
		totalDelta = 0
		align()
