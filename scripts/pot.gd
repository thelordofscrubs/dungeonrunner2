extends GroundItem
class_name Pot

var contents


func _init(cc, co).(cc, [26,30]):
	contents = co

func hit():
	connect("animation_finished",self,"destroy")
	play()

func destroy():
	get_parent().breakPot(coordinates)
	queue_free()
