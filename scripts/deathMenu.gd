extends CanvasLayer
class_name DeathMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var backToMenuB
var resetB

#func _init():
#	pause_mode = Node.PAUSE_MODE_PROCESS

# Called when the node enters the scene tree for the first time.
func _ready():
	set_layer(5)
	backToMenuB = PButton.new(1,2)
	backToMenuB.text = "Back To Main Menu"
	backToMenuB.connectTo("exitLevel")
	add_child(backToMenuB)
	resetB = PButton.new(2,2)
	resetB.text = "Reset Level"
	resetB.connectTo("resetLevel")
	add_child(resetB)

func exitLevel():
	get_parent().openMainMenu()

func resetLevel():
	get_parent().resetLevel()

