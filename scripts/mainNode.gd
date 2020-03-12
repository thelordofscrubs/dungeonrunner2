extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenuScene = preload("res://mainMenu.tscn")
var mainMenu

# Called when the node enters the scene tree for the first time.
func _ready(): 
	
	mainMenu = mainMenuScene.instance()
	add_child(mainMenu)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
