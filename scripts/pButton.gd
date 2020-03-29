extends Button
class_name PButton
	
var pressFun
var pos

func _init(p):
	pos = p

func _ready():
	var vp = get_viewport()
	rect_position = Vector2(vp.size[0]/2-100,vp.size[1]/4*pos)
	rect_size = Vector2(200,vp.size[1]/4-50)

func connectTo(f):
	pressFun = f

func _pressed():
	get_parent().call(pressFun)
