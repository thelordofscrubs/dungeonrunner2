extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenuScene = preload("res://mainMenu.tscn")
var levelScene = preload("res://lvlScene.tscn")
var currentLevel
var inGame = false
var paused = false
var inMenu = false
#var currentLevelP
var menuStack = []
var menuTypeStack = []
enum MENUTYPE{MAIN,PAUSE,DEATH,ENDLEVEL,SETTINGS}



# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_maximized(true)
	goToMenu(MENUTYPE.MAIN)

func openMainMenu():
	menuStack[-1].queue_free()
	menuStack.clear()
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
	menuStack.clear()
	currentLevel = levelScene.instance()
	add_child(currentLevel)
	currentLevel.startLevel(id)
	inGame = true
	paused = false
	inMenu = false
	get_tree().paused = false

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
			menu = PauseMenu.new()#Settings Menu doesn't exist yet
	if menuStack.size() > 0:
		menuStack[-1].queue_free()
	pushMenuStack(menu,menuType)
	add_child(menuStack[-1])

func removeMenu(menu):
	menu.queue_free()

func pushMenuStack(menu,menuType):
	menuStack.append(menu)
	menuTypeStack.append(menuType)

func popMenuStack():
	removeMenu(menuStack[-1])
	menuStack.pop_back()
	menuTypeStack.pop_back()
	if menuStack.size() > 0: 
		goToMenu(menuTypeStack[-1])

var darkened
var darkScreen

func toggleDarkScreen():
	print("toggling darkened mode")
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
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if paused:
			unPause()
		else:
			pauseGame()
	if inMenu:
		return
	if inGame == false:
		return
	
