extends GroundItem
class_name Coin

var value

func _init(cc, v).(cc, [48,48]):
    value = v

func _ready():
    print("coin has been added to the tree")