extends Node2D
class_name PauseMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var resumeB
var exitB
var settingsB

# Called when the node enters the scene tree for the first time.
func _ready():
	set_self_modulate(Color(1,1,1,0.5))
	resumeB = Button.new()
	resumeB.position = Vector2(50,50)
	resumeB.size = Vector2(200,150)
	resumeB.text = "Resume Game"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
