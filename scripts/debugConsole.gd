extends CanvasLayer
class_name DebugMenu

var userInput
var inputContainer
var inputField
var darkenSprite
var level

func _ready():
	level = get_parent().currentLevel 
	layer = 10
	darkenSprite = Sprite.new()
	darkenSprite.set_texture(load("res://otherArt/blackPixel.png"))
	darkenSprite.set_scale(Vector2(16000,16000))
	darkenSprite.set_modulate(Color(1,1,1,0.4))
	add_child(darkenSprite)
	inputContainer = Node2D.new()
	inputContainer.set_z_index(2)
	add_child(inputContainer)
	inputField = LineEdit.new()
	inputContainer.add_child(inputField)
	inputField.rect_position = Vector2(50,30)
	inputField.rect_size = Vector2(get_viewport().get_size()[0]-100,20)
	inputField.connect("text_entered", self, "debugCommand")
	inputField.grab_focus()

func debugCommand(s):
	inputField.clear()
	level.debugCommand(s)

	

