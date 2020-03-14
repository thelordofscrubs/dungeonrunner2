extends Sprite
class_name Projectile

var coordinates
var direction
var moveCounter = 0
var timer
var pixelPerSecond
var moveCounter1 = 0
var levelMap = {}
var bounds
var projectileId
var oldmod = [0.0, 0.0]
var newmod = [0.0, 0.0]

func _ready():
	#print("coordinates = "+str(coordinates)+ " and graphicalContainer's coords are "+str(get_parent().get_parent().position/Vector2(16,16)))
	#position = (coordinates-get_parent().get_parent().position/Vector2(16,16))*Vector2(16,16)
	#print("real position of arrow = "+str(position))
	#global_position = pcoords-get_parent().get_parent().position
	#position -= get_parent().position
	#print("real position of arrow = "+str(global_position))
	#levelMap = get_parent().get_parent().levelGrid
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "updatePos")
	timer.start(1.0/pixelPerSecond)
	scale = Vector2(1,1)
	z_index = 50

func updatePos():
	coordinates += direction
	set_position(coordinates)
#	print(str(bounds))
	for c in coordinates:
		if abs(c) >500:
			queue_free()
			#print("deleted arrow")
	if direction[0] > 0:
		newmod[0] = fmod(coordinates[0],16.0)
		if newmod[0] < oldmod[0]:
			#print("newmod[0] is smaller than oldmod[0], newmod = "+str(newmod[0])+" and oldmod = "+str(oldmod[0])+" and coordinates is currently" + str(coordinates))
			checkForTerrain()
		oldmod[0] = newmod[0]
	if direction[0] < 0:
		newmod[0] = fmod(coordinates[0],16.0)
		if newmod[0] > oldmod[0]:
			checkForTerrain()
		oldmod[0] = newmod[0]
	if direction[1] < 0:
		newmod[1] = fmod(coordinates[1],16.0)
		if newmod[1] > oldmod[1]:
			checkForTerrain()
		oldmod[1] = newmod[1]
	if direction[1] > 0:
		newmod[1] = fmod(coordinates[1],16.0)
		if newmod[1] < oldmod[1]:
			#print("newmod[1] is smaller than oldmod[1], newmod = "+str(newmod[1])+" and oldmod = "+str(oldmod[1])+" and coordinates is currently" + str(coordinates))
			checkForTerrain()
		oldmod[1] = newmod[1]

func checkForTerrain():
	pass
	#print("projectile number "+str(projectileId)+" checking for terrain at coordinates : "+str((coordinates/16).floor()))
	#print("cft ran")

func _draw():
	draw_rect(get_rect(),Color(0,255,0),false)
	#draw_texture(get_texture(),Vector2(0,0))

func _init(coords, dir, id, persec):
	projectileId = id
	pixelPerSecond = persec
	#print("arrow Spawned at "+str(coords)+", going towards Vector2"+str(dir))
	#print("real position of player = "+str(pixelCoordinates))
	coordinates = coords
	oldmod[0] = fmod(coords[0], 16.0)
	oldmod[1] = fmod(coords[1], 16.0)
	position = (coords)
	direction = dir
	set_centered(true)
	set_rotation(atan2(dir[1],dir[0])+ PI/2)
	


