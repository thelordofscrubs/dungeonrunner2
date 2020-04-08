extends Object
class_name PathFinder
enum IMPASSABLE{WALL = 1, DOOR = 3}

var level


func _init(levelNode):
    level = levelNode

func pathTo(from:Vector2, to:Vector2):
    var points = []
    var visitedPoints = []

checkAdjacentTiles(points):
    var newPoints
    for point in points:
        if !points.has(point+Vector2(0,1)):
            newPoints.add(point+Vector2(0,1), )
            
        if point+Vector2(1,0)

        if point+Vector2(0,-1)

        if point+Vector2(-1,0)
        checkTile()
    

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
        distFrom = df