extends Node
class_name Monster
enum TILE{OOB,FLOOR,WALL,FINISH,DOOR,CHEST,KEY,POT}
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

func initSprite(spriteScene):
	print("Getting Monster Sprite")
	sprite = spriteScene.instance()
	sprite.set_position((coordinates)*Vector2(16,16))
	get_parent().add_child(sprite)
	healthBar = MonsterHealthBar.new(maxHealth,health)
	sprite.add_child(healthBar)

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
	sprite.queue_free()
	healthBar.queue_free()

func move(vec):
	coordinates += vec
	#facing = vec
	sprite.move(coordinates*16)
