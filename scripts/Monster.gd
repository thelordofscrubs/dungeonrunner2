extends AnimatedSprite
class_name Monster
enum TILE{FLOOR,WALL,FINISH,DOOR,CHEST,CHESTOPEN,CHARSPRITE,BLUESLIME,KEY,POT,BATSKELETON,DOOROPEN,BLUESLIMESIDE, OOB = -1}
enum DIRECTION {NORTH,EAST,SOUTH,WEST}
enum DAMAGETYPE{PHYSICAL,MAGICAL}
enum IMPASSABLE{WALL = 1, DOOR = 3}

var pfClass
var health 
var maxHealth 
var damage 
var coordinates
var facing
var player
var sprite
var attackTimer
var healthBar
var levelMap
var monsterID
var flying = false
var level
var entRect
var monsterSize = Vector2(1,1)
var rng
var iFrameTimer
var isInvincible = false

func _init(id_, p, c, f, hp, hpMax, dmg):
	monsterID = id_
	coordinates = c
	facing = f
	player = p
	entRect = Rect2(c, monsterSize)
	health = hp
	maxHealth = hpMax
	damage = dmg

func _ready():
	set_position((coordinates)*Vector2(16,16))
	set_z_index(1)
	healthBar = MonsterHealthBar.new(maxHealth,health)
	add_child(healthBar)
	level = get_parent()
	pfClass = PathFinder.new(level)
	rng = RandomNumberGenerator.new()
	rng.randomize()


func getMap(map):
	levelMap = map

func changeHealth(a):
	spawnDamageLabel(a)
	if typeof(a) == TYPE_STRING:
		return
	health += a
	if health > maxHealth:
		health = maxHealth
	healthBar.set_value(health)
	if health <= 0:
		die()

func die():
	level.monsters.erase(self)
	healthBar.queue_free()
	queue_free()

func move(vec):
	coordinates += vec
	entRect.position = coordinates
	set_position(coordinates*16)

func iFrameTimeout():
	isInvincible = false

func getHit(d, type):
	if isInvincible:
		return
	iFrameTimer = Timer.new()
	iFrameTimer.set_one_shot(true)
	iFrameTimer.connect("timeout", self, "iFrameTimeout")
	add_child(iFrameTimer)
	iFrameTimer.start(0.3)
	if flying == true && type == DAMAGETYPE.PHYSICAL:
		if rng.randf() < .2:
			changeHealth("Dodged!")
		else:
			changeHealth(-d)
	else:
		changeHealth(-d)
	isInvincible = true

func spawnDamageLabel(a):
	var dmgLabel = DamageLabel.new()
	dmgLabel.set_align(1)
	if typeof(a) == TYPE_STRING:
		dmgLabel.set_text(a)
	dmgLabel.set_text(str(a))
#	var posX = dmgLabel.get_size()[0]/2-8
	dmgLabel.set_position(position + Vector2(2,-10))
	dmgLabel.set_scale(Vector2(0.6,0.6))
	level.add_child(dmgLabel)

func isPointInSight(v1,v2):
	var rd = v1.direction_to(v2)
	var ray = v1+rd
	#print("casting ray from "+str(v1)+" to "+str(v2)+" with the ray direction being "+str(rd))
	while v2.distance_to(ray) > 1:
		if IMPASSABLE.values().has(level.levelGrid[ray.floor()]):
			#print("wall found at "+str(ray.floor()))
			return false
		ray += rd*0.5
	#print("ray has reached player")
	return true

class DamageLabel:
	extends Label
	
	var age = 0
	var timer
	var t = Theme.new()
	
	
	func _init():
		t.set_color("font_color","Label",Color(200,200,200))
		set_theme(t)
	
	func _ready():
		timer = Timer.new()
		timer.connect("timeout",self,"moveSelf")
		add_child(timer)
		timer.start(0.01)
	
	func moveSelf():
		rect_position -= Vector2(0,.5)
		age += 1
		modulate.a -=.02
		#t.set_color("font_color","Label",Color(200,200,200,a))
		#set_theme(t)
		if age > 50:
			get_parent().remove_child(self)
			queue_free()
	
