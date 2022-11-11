extends Node2D
#load mushroom from the instances folder
var mushroom  = preload('res://instances/Mushroom1.tscn')
#randomly spawn three mushrooms on ready
func _ready():
	randomize()
	var x
	for i in 3:
		var newMush = mushroom.instance()
		x = rand_range(-280, 280)
		newMush.set_position(Vector2(x, 375))
		add_child(newMush)
	pass
		
