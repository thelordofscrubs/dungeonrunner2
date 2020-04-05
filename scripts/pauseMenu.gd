extends CanvasLayer
class_name PauseMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var resumeB
var exitB
var settingsB
var resetB

#func _init():
#	pause_mode = Node.PAUSE_MODE_PROCESS

# Called when the node enters the scene tree for the first time.
func _ready():
	set_layer(5)
	resumeB = PButton.new(1,4)
	resumeB.text = "Resume Game"
	resumeB.connectTo("resume")
	add_child(resumeB)
	settingsB = PButton.new(2,4)
	settingsB.text = "Settings"
	settingsB.connectTo("openSettings")
	add_child(settingsB)
	resetB = PButton.new(3,4)
	resetB.text = "Reset Level"
	resetB.connectTo("resetLevel")
	add_child(resetB)
	exitB = PButton.new(4,4)
	exitB.text = "Exit To Main Menu"
	exitB.connectTo("exitLevel")
	add_child(exitB)


func resetLevel():
	get_parent().resetLevel()

func resume():
	get_parent().unPause()

func openSettings():
	get_parent().openSettingsMenu()

func exitLevel():
	get_parent().openMainMenu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
