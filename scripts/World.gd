extends Node2D
#load mushroom from the instances folder
var mushroom  = preload('res://instances/Mushroom1.tscn')
#randomly spawn three mushrooms on ready
func _ready():
	#randomize()
	var x = -200
	for i in 3:
		var newMush = mushroom.instance()
		newMush.set_position(Vector2(x, 375))
		add_child(newMush)
		x += 200
	pass
		
