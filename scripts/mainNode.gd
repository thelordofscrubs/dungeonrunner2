extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenuScene = preload("res://mainMenu.tscn")
var mainMenu
var currentLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_maximized(true)
	mainMenu = mainMenuScene.instance()
	add_child(mainMenu)

func openMainMenu():
	currentLevel.queue_free()
	mainMenu = mainMenuScene.instance()
	add_child(mainMenu)

func beginLevel():
	mainMenu.queue_free()
	currentLevel = load("res://lvlScene.tscn").instance()
	add_child(currentLevel)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("forw"):
		currentLevel.player.move(0,delta)
	if Input.is_action_pressed("back"):
		currentLevel.player.move(2,delta)
	if Input.is_action_pressed("left"):
		currentLevel.player.move(3,delta)
	if Input.is_action_pressed("right"):
		currentLevel.player.move(1,delta)
	if Input.is_action_just_released("atk1"):
		currentLevel.player.attack(1)
	if Input.is_action_just_released("atk2"):
		currentLevel.player.attack(2)
	if Input.is_action_just_released("chgw"):
		currentLevel.player.changeWeapon()
