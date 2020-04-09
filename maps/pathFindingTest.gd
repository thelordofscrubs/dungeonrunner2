tool
extends Node

export(Vector2) var startingLoc = Vector2(1,1)
export(Vector2) var endingLoc = Vector2(17,17)
export(bool) var startPathing = false setget startP
export(bool) var stepPath = false setget stepP
export(bool) var finishPath = false setget finishP
export(bool) var clearPath = false setget clearPathf
var pq
onready var tm = get_child(0)
var py

func clearPathf(_b):
	if !tm:
		tm = get_child(0)
	tm.queue_free()
	var t = load("res://maps/pfttm.tscn").instance()
	add_child(t)
	t.set_owner(self)
	tm = t

func stepP(_b):
	if !py:
		print("Path has not been started")
		return
	py = py.resume()

func finishP(_b):
	while py is GDScriptFunctionState:
		py = py.resume()
	print(py)

func startP(_b):
	startPath()

func startPath():
	clearPathf(false)
	pq = PQT.new()
	var pfClass = PathFinderT.new(tm, pq)
	py = pfClass.pathTo(startingLoc, endingLoc)

class PathFinderT:
	enum IMPASSABLE{WALL = 1}
	
	var level 
	var pq

	func _init(levelNode, pq1):
		level = levelNode
		pq = pq1
	
	func pathTo(from:Vector2, to:Vector2):
		var path = []
		var visitedPoints = []
		var heapObjects = []
		pq.add(Point.new(from, 0, to.distance_to(from), from), 0+to.distance_to(from))
		level.set_cellv(from, 4)
		level.set_cellv(to, 4)
		var loopC = 0
		while pq.peek().coords != to:
			if loopC > 299:
				return "can't find a viable path under 300 units long"
			var popped = pq.pop()
			level.set_cellv(popped.coords, 5)
			visitedPoints.append(popped)
			var newTiles = checkAdjacentTiles(popped, to)
			print(newTiles)
			heapObjects = pq.returnObjectsInArray()
			var newTiles1 = []
			for tile in newTiles:
				var isNew = true
				if level.get_cellv(tile.coords) == 0:
					level.set_cellv(tile.coords, 2)
				for o in heapObjects:
					if o.coords == tile.coords:
						if tile.routeCost < o.routeCost:
							pq.erase(o)
							pq.add(tile, tile.getPrio())
							isNew = false
							break
				for t in visitedPoints:
					if t.coords == tile.coords:
						isNew = false
						break
				if isNew:
					newTiles1.append(tile)
			for tile in newTiles1:
				pq.add(tile, tile.getPrio())
			loopC += 1
			yield()
		path.append(pq.pop())
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
		print(point)
		var newPoints = []
		for x in range(-1,2):
			for y in range(-1,2):
				#print("(",x,",",y,")")
				if x == 0 and y == 0:
					continue
				var newCoordinate = point.coords+Vector2(x,y)
				if checkTile(newCoordinate):
					newPoints.append(Point.new(newCoordinate, point.routeCost+sqrt(abs(x)+abs(y)), to.distance_to(newCoordinate), point.coords))
		return newPoints
		
	func checkTile(vp):
		#print(vp)
		#print(level.get_cellv(vp))
		var stupid = (IMPASSABLE.values().has(level.get_cellv(vp)))
		#print(stupid)
		return !stupid
	
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
		func _to_string():
			return "coords = " + str(coords) + ", from = " + str(from)

class PQT:
	export(Array) var queue = [] setget q

	func q(_b):
		pass

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
			if (queue[x].object.coords == object.coords):
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