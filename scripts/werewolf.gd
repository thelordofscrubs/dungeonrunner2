extends Monster
class_name Werewolf

var pointsToVisit = []
var pathing = false
var arrivalTimer
var updatePathTimer
var inSight = true

func _init(a,b,c,f).(a,b,c,f,30.0,30,15):
	pass
	
func _ready():
	var grabber = AtlasHandler.new()
	var frames = SpriteFrames.new()
	frames.add_animation("move")
	frames.add_animation("attack")
	frames.add_frame("move",grabber.grab(37))
	frames.add_frame("attack",grabber.grab(38))
	set_sprite_frames(frames)
	play("move")
	set_centered(false)
	attackTimer = Timer.new()
	add_child(attackTimer)
	attackTimer.connect("timeout",self,"attack")
	attackTimer.start(2)
	#arrivalTimer = Timer.new()
	#arrivalTimer.connect("timeout", self, "checkForTurn")
	#add_child(arrivalTimer)
	#arrivalTimer.start(0.5)
	#updatePathTimer = Timer.new()
	#updatePathTimer.connect("timeout", self, "updatePath")
	#add_child(updatePathTimer)
	#updatePathTimer.start(1)

func findPathTo(c):
	pointsToVisit = pfClass.pathTo(coordinates.floor(), c.floor())
	print(pointsToVisit)

func checkForTurn():
	if pathing and ((facing.sign() + coordinates.direction_to(pointsToVisit[0]).sign()).length_squared() == 0):
		pointsToVisit.pop_back()
		turnTo(pointsToVisit[-1])

func turnTo(p):
	facing = coordinates.direction_to(p)

func updatePath():
	if isPointInSight(coordinates, player.coordinates):
		pathing = false
		inSight = true
	else:
		findPathTo(player.coordinates.floor())
		pathing = true
		inSight = false
var pathingTime = 0.0
func moveInPath(delta):
	pathingTime += delta
	if !pathing || pathingTime > 1 || pointsToVisit.size() < 1:
		findPathTo(player.coordinates.floor())
		pathingTime = 0.0
	pathing = true
	coordinates = coordinates.move_toward(pointsToVisit[-1],delta)
	entRect.position = coordinates
	set_position(coordinates*16)
	if coordinates == pointsToVisit[-1]:
		pointsToVisit.pop_back()


func attemptMove(delta):
	if isPointInSight(coordinates,player.coordinates):
		pathing = false
		coordinates = coordinates.move_toward(player.coordinates,delta)
		entRect.position = coordinates
		set_position(coordinates*16)
		return
	else:
		moveInPath(delta)
	#var moveVector = facing*delta
	#var ec = coordinates+Vector2(.5,.5)+facing*.5
	#var pv = Vector2(facing[1],facing[0])*.5
	#var moveChecks = [Vector2(0,0),Vector2(0,0)]
	#moveChecks[0] = (ec+pv*.8+moveVector).floor()
	#moveChecks[1] = (ec-pv*.8+moveVector).floor()
	#if detectWall(moveChecks):
	#	return
	#moveVector = facing*delta
	#move(moveVector)

func detectWall(v):
		match level.levelGrid[v]:
			TILE.WALL:
				return true
			TILE.DOOR:
				return true

func attack():
	if player.playerRect.intersects(entRect):
		player.takeDamage(damage)
	
