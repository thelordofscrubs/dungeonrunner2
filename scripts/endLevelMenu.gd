extends CanvasLayer
class_name EndLevelMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var backToMenuB

#func _init():
#	pause_mode = Node.PAUSE_MODE_PROCESS

# Called when the node enters the scene tree for the first time.
func _ready():
	set_layer(5)
	backToMenuB = PButton.new(1)
	backToMenuB.text = "Back To Main Menu"
	backToMenuB.connectTo("exitLevel")
	add_child(backToMenuB)

func exitLevel():
	get_parent().openMainMenu()

class PButton:
	extends Button
	
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
