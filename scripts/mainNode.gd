extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenuScene = preload("res://mainMenu.tscn")
var mainMenu
var levelScene = preload("res://lvlScene.tscn")
var currentLevel
var inGame = false
var pauseMenu
var paused = false
#var currentLevelP

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_maximized(true)
	mainMenu = mainMenuScene.instance()
	add_child(mainMenu)

func openMainMenu():
	inGame = false
	currentLevel.queue_free()
	mainMenu = mainMenuScene.instance()
	add_child(mainMenu)

func pauseGame():
	inGame = false
	paused = true
	currentLevel.darken(.4)
	for control in currentLevel.get_node("uiContainer").get_children():
		control.set_theme(Theme.new())
	get_tree().paused = true
	pauseMenu = PauseMenu.new()
	add_child(pauseMenu)

func unPause():
	paused = false
	inGame = true
	currentLevel.darken(1)
	get_tree().paused = false
	pauseMenu.queue_free()

func beginLevel(id):
	mainMenu.queue_free()
	currentLevel = levelScene.instance()
	add_child(currentLevel)
	currentLevel.startLevel(id)
	inGame = true

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if paused:
			unPause()
		else:
			pauseGame()
	if inGame == false:
		return
	if Input.is_action_just_released("atk1"):
		currentLevel.player.attack(1)
	if Input.is_action_just_released("atk2"):
		currentLevel.player.attack(2)
	if Input.is_action_just_released("chgw"):
		currentLevel.player.changeWeapon()
	currentLevel.moveMonsters(delta)
	if Input.is_action_pressed("forw") and Input.is_action_pressed("left"):
		currentLevel.movePlayer(7,delta)
		return
	if Input.is_action_pressed("back") and Input.is_action_pressed("left"):
		currentLevel.movePlayer(6,delta)
		return
	if Input.is_action_pressed("back") and Input.is_action_pressed("right"):
		currentLevel.movePlayer(5,delta)
		return
	if Input.is_action_pressed("forw") and Input.is_action_pressed("right"):
		currentLevel.movePlayer(4,delta)
		return
	if Input.is_action_pressed("forw"):
		currentLevel.movePlayer(0,delta)
		return
	if Input.is_action_pressed("back"):
		currentLevel.movePlayer(2,delta)
		return
	if Input.is_action_pressed("left"):
		currentLevel.movePlayer(3,delta)
		return
	if Input.is_action_pressed("right"):
		currentLevel.movePlayer(1,delta)
		return
	if (currentLevel.player.moving):
		currentLevel.player.stopMoving()
	
