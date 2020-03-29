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
	backToMenuB = PButton.new(1,1)
	backToMenuB.text = "Back To Main Menu"
	backToMenuB.connectTo("exitLevel")
	add_child(backToMenuB)

func exitLevel():
	get_parent().openMainMenu()
