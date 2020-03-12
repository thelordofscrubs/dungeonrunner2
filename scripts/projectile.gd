extends Sprite
class_name Projectile

var coordinates
var direction
var moveCounter = 0
#var pcoords
var timer
var moveCounter1 = 0
var levelMap = {}

func _ready():
	#print("coordinates = "+str(coordinates)+ " and graphicalContainer's coords are "+str(get_parent().get_parent().position/Vector2(16,16)))
	#position = (coordinates-get_parent().get_parent().position/Vector2(16,16))*Vector2(16,16)
	#print("real position of arrow = "+str(position))
	#global_position = pcoords-get_parent().get_parent().position
	#position -= get_parent().position
	#print("real position of arrow = "+str(global_position))
	#levelMap = get_parent().get_parent().levelGrid
	pass

func _init(coords, dir, initialPlayerCoords):
	#print("arrow Spawned at "+str(coords)+", going towards Vector2"+str(dir))
	#print("real position of player = "+str(pixelCoordinates))
	coordinates = coords
	position = (coords/Vector2(2,2))
	direction = dir
	#pcoords = pixelCoordinates
	centered = false
