extends Object
class_name PathFinder
enum IMPASSABLE{WALL = 1, DOOR = 3}

var level 

func _init(levelNode):
	level = levelNode

func pathTo(from:Vector2, to:Vector2):
	var pointHeap = PriorityQueue.new()
	var path = []
	var visitedPoints = []
	var heapObjects = []
	pointHeap.add(Point.new(from, 0, to.distance_to(from), from), 0+to.distance_to(from))
	while true:
		if pointHeap.peek().coords == to:
			break
		var popped = pointHeap.pop()
		visitedPoints.append(popped)
		var newTiles = checkAdjacentTiles(popped, to)
		heapObjects = pointHeap.returnObjectsInArray()
		for tile in newTiles:
			for o in heapObjects:
				if o.coords == tile.coords:
					if tile.routeCost < o.routeCost:
						pointHeap.erase(o)
						pointHeap.add(tile, tile.getPrio())
						newTiles.erase(tile)
		for tile in newTiles:
			pointHeap.add(tile, tile.getPrio())
	path.append(pointHeap.pop())
	while path[-1].coords != from:
		for point in visitedPoints:
			if point.coords == path[-1].from:
				path.append(point)
				break
	var cPath = []
	for p in range(1, path.size()):
		if path[p].dir != path[p-1].dir:
			cPath.append(path[p].coords)
	return cPath

func checkAdjacentTiles(point, to):
	var newPoints = []
	for x in range(-1,1):
		for y in range(-1,1):
			if x == 0 and y == 0:
				continue
			var newCoordinate = Vector2(point.coords+Vector2(x,y))
			if checkTile(newCoordinate):
				newPoints.append(Point.new(newCoordinate, point.routeCost+sqrt(abs(x)+abs(y)), to.distance_to(newCoordinate), point.coords))
	return newPoints
	
func checkTile(vp):
	return !(IMPASSABLE.values().has(level.levelGrid[vp]))

class Point:
	var coords
	var distTo
	var routeCost
	var from
	var dir

	func _init(c,dt,df,f):
		coords = c
		distTo = dt
		routeCost = df
		from = f
		dir = f.direction_to(c)

	func getPrio():
		return distTo+routeCost

	func add(v):
		return coords + v
