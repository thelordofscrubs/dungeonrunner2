extends Button
class_name PButton
	
var pressFun
var pos
var buttonRows

func _init(p, ba):
	pos = p
	buttonRows = ba


func _ready():
	var vp = get_viewport()
	rect_position = Vector2(vp.size[0]/2-100,vp.size[1]/(buttonRows+2)*pos)
	rect_size = Vector2(200,vp.size[1]/(buttonRows+2)-50)

func connectTo(f):
	pressFun = f

func _pressed():
	get_parent().call(pressFun)
