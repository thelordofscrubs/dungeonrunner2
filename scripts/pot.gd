extends AnimatedSprite
class_name Pot

var contents
var coordinates


func _init(cc, co):
    coordinates = cc
    contents = co

func _ready():
    var grabber = AtlasHandler.new()
    var frames = SpriteFrames.new()
    for x in range(26,30):
        frames.add_frame("default",grabber.grab(x))
    frames.set_animation_loop("default",false)
    frames.set_animation_speed(16)
    set_sprite_frames(frames)
    set_position(coordinates*16)

func hit():
    connect("animation_finished",self,"destroy")
    play()

func destroy():
    get_parent().breakPot(coordinates)
    queue_free()
