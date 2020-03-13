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
		if abs(c) > 200:
			queue_free()
			#print("deleted arrow")

func _draw():
	draw_rect(get_rect(),Color(0,255,0),false)
	#draw_texture(get_texture(),Vector2(0,0))

func _init(coords, dir, persec):
	pixelPerSecond = persec
	#print("arrow Spawned at "+str(coords)+", going towards Vector2"+str(dir))
	#print("real position of player = "+str(pixelCoordinates))
	coordinates = coords
	position = (coords)
	direction = dir
	set_centered(true)
	set_rotation(atan2(dir[1],dir[0])+ PI/2)
	


