extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenuScene = preload("res://mainMenu.tscn")
var levelScene = preload("res://lvlScene.tscn")
var currentLevel
var inGame = false#For checking if in a level
var paused = false
var inMenu = false#for every menu expect pause button, so that you can't pause in other menus
#var currentLevelP
var currentMenu
var menuTypeStack = []
enum MENUTYPE{MAIN,PAUSE,DEATH,ENDLEVEL,SETTINGS}



# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_maximized(true)
	goToMenu(MENUTYPE.MAIN)

func openMainMenu():
	currentMenu.queue_free()
	menuTypeStack.clear()
	if inGame:
		currentLevel.queue_free()
		toggleDarkScreen()
	inGame = false;
	inMenu = true;
	goToMenu(MENUTYPE.MAIN)

func die():
	inGame = false
	inMenu = true
	paused = true
	currentLevel.queue_free()
	goToMenu(MENUTYPE.DEATH)
#	for control in currentLevel.get_node("uiContainer").get_children():
#		control.set_theme(Theme.new())
	get_tree().paused = true

func finishLevel():
	inGame = false
	inMenu = true
	paused = true
	currentLevel.queue_free()

#	for control in currentLevel.get_node("uiContainer").get_children():
#		control.set_theme(Theme.new())
	get_tree().paused = true
	goToMenu(MENUTYPE.ENDLEVEL)
func pauseGame():
	paused = true
	inGame = true
	toggleDarkScreen()
#	for control in currentLevel.get_node("uiContainer").get_children():
#		control.set_theme(Theme.new())
	get_tree().paused = true
	goToMenu(MENUTYPE.PAUSE)

func resetLevel():
	if inGame:
		currentLevel.queue_free()
		toggleDarkScreen()
	yield(get_tree(),"idle_frame")
	beginLevel(0)

func unPause():
	toggleDarkScreen()
	paused = false
	inGame = true
	get_tree().paused = false
	popMenuStack()


func beginLevel(id):
	popMenuStack()
	menuTypeStack.clear()
	currentMenu.queue_free()
	currentLevel = levelScene.instance()
	add_child(currentLevel)
	currentLevel.startLevel(id)
	inGame = true
	paused = false
	inMenu = false
	get_tree().paused = false

func openSettingsMenu():
	goToMenu(MENUTYPE.SETTINGS)

func goToMenu(menuType):
	var menu
	match menuType:
		MENUTYPE.MAIN:
			menu = mainMenuScene.instance()
		MENUTYPE.ENDLEVEL:
			menu = EndLevelMenu.new()
		MENUTYPE.PAUSE:
			menu = PauseMenu.new()
		MENUTYPE.DEATH:
			menu = DeathMenu.new()
		MENUTYPE.SETTINGS:
			menu = SettingsMenu.new()
	if currentMenu:
		currentMenu.queue_free()
	currentMenu = menu
	pushMenuStack(menuType)
	add_child(currentMenu)

func pushMenuStack(menuType):
	menuTypeStack.append(menuType)

func popMenuStack():
	menuTypeStack.pop_back()
	if menuTypeStack.size() > 0: 
		goToMenu(menuTypeStack[-1])

var darkened
var darkScreen

func toggleDarkScreen():
	#print("toggling darkened mode")
	if darkened:
		darkScreen.queue_free()
		darkened = false
	else:
		darkScreen = DarkScreen.new()
		add_child(darkScreen)
		darkened = true

class DarkScreen:
	extends CanvasLayer

	var bs

	func _ready():
		bs = Sprite.new()
		bs.set_texture(load("res://otherArt/blackPixel.png"))
		bs.set_modulate(Color(1,1,1,0.6))
		bs.set_scale(Vector2(16000,16000))
		add_child(bs)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if inMenu:
		return
	if !inGame:
		return
	if Input.is_action_just_pressed("pause"):
		if paused:
			unPause()
		else:
			pauseGame()
	
