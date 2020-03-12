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

func _init(id_, pc, c, f, hp, hpMax, dmg):
	monsterID = id_
	coordinates = c
	facing = f
	playerCoordinates = pc
	health = hp
	maxHealth = hpMax
	damage = dmg

func _ready():
	healthBar = monsterHealthBar.new(coordinates,maxHealth, health, name)
	healthBar.set_position((coordinates-playerCoordinates)*Vector2(16,16)+Vector2(-10,16))
	get_node("../graphicsContainer/spriteContainer").add_child(healthBar)

func getMap(map):
	levelMap = map

func changeHealth(a):
	sprite.takeDamage(a)
	if typeof(a) == TYPE_STRING:
		return
	health += a
	if health > maxHealth:
		health = maxHealth
	healthBar.set_value(health)
	if health <= 0:
		die()

func die():
	get_node("../graphicsContainer/spriteContainer").remove_child(sprite)
	sprite.queue_free()
	get_node("../graphicsContainer/spriteContainer").remove_child(healthBar)
	healthBar.queue_free()
	get_parent().killMonster(self)
	get_parent().remove_child(self)

func move(vec,time = 1):
	coordinates += vec
	#facing = vec
	sprite.move(vec)
	healthBar.move(vec, 1)
