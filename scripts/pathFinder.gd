class_name PathFinder
enum IMPASSABLE{WALL = 1}
	
var level 

func _init(levelNode):
	level = levelNode

func pathTo(from:Vector2, to:Vector2):
	var path = []
	var visitedPoints = []
	var pq = PriorityQueue.new()
	pq.add(Point.new(from, 0, to.distance_to(from), from), 0+to.distance_to(from))
	while pq.peek().coords != to:
		var popped = pq.pop()
		visitedPoints.append(popped)
		var newTiles = checkAdjacentTiles(popped, to)
		var heapObjects = pq.returnObjectsInArray()
		var newTiles1 = []
		for tile in newTiles:
			var isNew = true
			for o in heapObjects:
				if o.coords == tile.coords:
					isNew = false
					if tile.routeCost < o.routeCost:
						pq.erase(o)
						pq.add(tile, tile.getPrio())
						break
			for t in visitedPoints:
				if t.coords == tile.coords:
					isNew = false
					break
			if isNew:
				newTiles1.append(tile)
		for tile in newTiles1:
			pq.add(tile, tile.getPrio())
		heapObjects = pq.returnObjectsInArray()
		if heapObjects.size()<2:
			return "Could not find suitable path"
	path.append(pq.pop())
	while path[-1].coords != from:
		for point in visitedPoints:
			if point.coords == path[-1].from:
				path.append(point)
				break
	var cPath = []
	for p in range(1, path.size()-1):
		if path[p].dir != path[p+1].dir:
			cPath.append(path[p].coords)	
	return cPath

func checkAdjacentTiles(point, to):
	var newPoints = []
	for x in range(-1,2):
		for y in range(-1,2):
			if x == 0 and y == 0:
				continue
			var newCoordinate = point.coords+Vector2(x,y)
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

	func _init(c,df,dt,f):
		coords = c
		distTo = dt
		routeCost = df
		from = f
		dir = f.direction_to(c)

	func getPrio():
		return pow(distTo,2)+routeCost

	func add(v):
		return coords + v
	func _to_string():
		return "coords = " + str(coords) + ", from = " + str(from)
