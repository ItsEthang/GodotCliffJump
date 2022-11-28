extends Node2D
#load mushroom from the instances folder
var mushroom  = preload('res://instances/Mushroom1.tscn')


var mushArr = []
func _ready():
	#initially spawn the mushrooms with 200 units apart from each other
	var x = -200
	for i in 3:
		var newMush = mushroom.instance()
		newMush.set_position(Vector2(x, 375))
		add_child(newMush)
		mushArr.push_back(newMush)
		x += 200
	
	pass
	
		
