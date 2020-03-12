extends Node
class_name Monster
enum DIRECTION {NORTH,EAST,SOUTH,WEST}
var health 
var maxHealth 
var damage 
var coordinates
var facing
var playerCoordinates
var sprite
var attackTimer
var healthBar
var moveTimer
var levelMap
var monsterID

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
