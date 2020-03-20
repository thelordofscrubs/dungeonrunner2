extends CanvasLayer
class_name PauseMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var resumeB
var exitB
var settingsB

#func _init():
#	pause_mode = Node.PAUSE_MODE_PROCESS

# Called when the node enters the scene tree for the first time.
func _ready():
	set_layer(5)
	resumeB = PButton.new(1)
	resumeB.text = "Resume Game"
	resumeB.connectTo("resume")
	add_child(resumeB)
	settingsB = PButton.new(2)
	settingsB.text = "Settings"
	settingsB.connectTo("openSettings")
	add_child(settingsB)
	exitB = PButton.new(3)
	exitB.text = "Exit To Main Menu"
	exitB.connectTo("exitLevel")
	add_child(exitB)

func resume():
	get_parent().unPause()

func openSettings():
	pass

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
		rect_position = Vector2(vp.size[0]/2-100,vp.size[1]/5*pos)
		rect_size = Vector2(200,vp.size[1]/5-50)
	
	func connectTo(f):
		pressFun = f
	
	func _pressed():
		get_parent().call(pressFun)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
