extends Sprite

func move(vec):
	set_position(vec)

func takeDamage(a):
	var dmgLabel = damageLabel.new()
	dmgLabel.set_align(1)
	if typeof(a) == TYPE_STRING:
		dmgLabel.set_text(a)
	dmgLabel.set_text(str(a))
	var posX = dmgLabel.get_size()[0]/2-8
	dmgLabel.set_position(position+Vector2(4,5))
	dmgLabel.set_scale(Vector2(0.6,0.6))
	get_parent().add_child(dmgLabel)
	dmgLabel.startTimer()


class damageLabel:
	extends Label
	
	var age = 0
	var timer
	var t = Theme.new()
	var a = 255
	
	
	func _init():
		t.set_color("font_color","Label",Color(255,255,255,255))
		set_theme(t)
	
	func startTimer():
		timer = Timer.new()
		timer.connect("timeout",self,"moveSelf")
		add_child(timer)
		timer.start(0.01)
	
	func moveSelf():
		rect_position -= Vector2(0,1)
		age += 1
		a -= 3
		t.set_color("font_color","Label",Color(a,a,a,a))
		set_theme(t)
		if age > 50:
			get_parent().remove_child(self)
			queue_free()
