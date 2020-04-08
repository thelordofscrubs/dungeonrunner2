class_name PriorityQueue

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
