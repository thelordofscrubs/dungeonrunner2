extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenuScene = preload("res://mainMenu.tscn")
var mainMenu
var currentLevel

# Called when the node enters the scene tree for the first time.
func _ready(): 
	mainMenu = mainMenuScene.instance()
	add_child(mainMenu)

func beginLevel():
	mainMenu.queue_free()
	currentLevel = load("res://lvlScene.tscn").instance()
	add_child(currentLevel)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("forw"):
		pass
	if Input.is_action_pressed("back"):
		pass
	if Input.is_action_pressed("left"):
		pass
	if Input.is_action_pressed("right"):
		pass
	if Input.is_action_pressed("atk1"):
		pass
