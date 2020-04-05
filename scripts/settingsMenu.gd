extends CanvasLayer
class_name SettingsMenu

var backButton


func _ready():
    backButton = PButton.new(4, 4)
    backButton.connectTo("popSelf")
    add_child(backButton)



func popSelf():
    get_node("/root/mainControlNode").popMenuStack()