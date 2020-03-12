extends Monster

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spriteScene = preload("res://sprites/blueSlimeSprite.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	health = 10.0
	maxHealth = 10
	sprite = spriteScene.instance()
	sprite.set_position((coordinates-playerCoordinates)*Vector2(16,16))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
