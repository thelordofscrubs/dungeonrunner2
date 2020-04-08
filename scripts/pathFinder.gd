extends Object
class_name PathFinder
enum IMPASSABLE{WALL = 1, DOOR = 3}

var level

func _init(levelNode):
    level = levelNode

func pathTo(from:Vector2, to:Vector2):
    var pointHeap = PriorityQueue.new()
    var visitedPoints = []

func checkAdjacentTiles(points, from, to):
    var newPoints
    
    

func lineToWall(from, to):
    var curTile = from
    var lastTile = from
    while true:
        curTile = advanceTile(curTile, to)
        if curTile == lastTile:
            return curTile
        lastTile = curTile

func advanceTile(c, d):
    var dir = c.direction_to(d)
    var newT = (c+dir).floor()
    if checkTile(newT):
        return newT
    return c

func checkTile(vp):
	return !(IMPASSABLE.values().has(level.levelGrid[vp]))

class Point:
    var coordinates
    var distTo
    var distFrom

    func _init(c,dt,df):
        coordinates = c
        distTo = dt
        distFrom = d

    func add(v):
        return coordinates + v