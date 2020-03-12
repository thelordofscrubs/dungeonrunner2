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
var flying

func _init(id_,c = Vector2(1,1), f = DIRECTION.NORTH):
	monsterID = id_
	coordinates = c
	facing = f
	
