extends GroundItem
class_name Pot

var contents


func _init(cc, co).(cc, [26,29]):
	contents = co

func _ready():
	frames.set_animation_speed("default",12)

func hit():
	connect("animation_finished",self,"destroy")
	play()

func destroy():
	get_parent().breakPot(coordinates)
	queue_free()
