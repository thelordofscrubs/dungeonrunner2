extends Camera2D
class_name PlayerCam

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var totalDelta = 0
var tp

#func _init(c):
#	tp=c

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("setting cam position to "+str(tp))
	#set_position(tp)
	#print("cam pos after setting: "+str(get_camera_position()))
	#set_position()
	set_enable_follow_smoothing(true)
	set_zoom(Vector2(.5,.5))
	set_h_drag_enabled(false)
	set_v_drag_enabled(false)
	make_current()
	set_anchor_mode(1)
	#set_offset(Vector2(-200,-450))
	#print("camera spawned at "+str(get_camera_position())+" with center at "+str(get_camera_screen_center()))




