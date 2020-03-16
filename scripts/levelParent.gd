extends Node2D
class_name LevelParent

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level

# Called when the node enters the scene tree for the first time.
func _ready():
	level = LevelNode.new()
	add_child(level)
	 