tool
extends Node

export(Vector2) var startingLoc = Vector2(1,1)
export(Vector2) var endingLoc = Vector2(17,17)
export(bool) var startPathing = false
export(bool) var clearPath = false

onready var tm = get_node("TM")

func clearPath():
	tm = load("res://maps/pfttm.tscn").instance()

func _run():
	if startPathing:
		startPathing = false
		startPath()
	if clearPath:
		clearPath = false
		clearPath()

func startPath():
	var pfClass = PathFinderT.new(tm)
	pfClass.pathTo(startingLoc, endingLoc)

class PathFinderT:
	enum IMPASSABLE{WALL = 1}
	
	var level 
	
	func _init(levelNode):
		level = levelNode
	
	func pathTo(from:Vector2, to:Vector2):
		var pointHeap = PriorityQueue.new()
		var path = []
		var visitedPoints = []
		var heapObjects = []
		pointHeap.add(Point.new(from, 0, to.distance_to(from), from), 0+to.distance_to(from))
		level.set_cellv(from, 4)
		level.set_cellv(to, 4)
		while pointHeap.peek().coords != to:
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
				var newCoordinate = point.coords+Vector2(x,y)
				if checkTile(newCoordinate):
					newPoints.append(Point.new(newCoordinate, point.routeCost+sqrt(abs(x)+abs(y)), to.distance_to(newCoordinate), point.coords))
		return newPoints
		
	func checkTile(vp):
		return !(IMPASSABLE.values().has(level.get_cell_v(vp)))
	
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

class PQT:
	var queue = []

	func add(object, priority):
		queue.append(PriorityObject.new(object,priority))
		var curr = queue.size()-1
		while (queue[curr].priority < queue[heapParent(curr)].priority && curr != 0):
			var temp = queue[curr]
			queue[curr] = queue[heapParent(curr)]
			queue[heapParent(curr)] = temp
			curr = heapParent(curr)

	func returnObjectsInArray():
		var oArray = []
		for po in queue:
			oArray.append(po.object)
		return oArray

	func has(t):
		var oArray = []
		for po in queue:
			oArray.append(po.object)
		return oArray.has(t)

	func pop():
		var popped = queue.front().object
		queue[0] = queue[-1]
		queue.pop_back()
		minHeapify(1)
		return popped

	func peek():
		return queue[0].object

	func erase(object):
		for x in queue.size():
			if (queue[x].object == object):
				queue.remove(x)
				return

	static func heapParent(i):
		return floor((i/2))-1
	static func left(i):
		return 2*i+1
	static func right(i):
		return 2*i+2
	func minHeapify(i):
		var l = left(i)
		var r = right(i)
		var smallest = i
		if (l < queue.size() && queue[l].priority < queue[i].priority):
			smallest = l
		if (r < queue.size() && queue[r].priority < queue[smallest].priority):
			smallest = r
		if (smallest != i):
			var temp = queue[i]
			queue[i] = queue[smallest]
			queue[smallest] = temp
			minHeapify(smallest) 

	class PriorityObject:
		var priority 
		var object
		func _init(object_, priority_):
			object = object_
			priority = priority_