extends Node2D
#load mushroom from the instances folder
var mushroom  = preload('res://instances/Mushroom1.tscn')

var mushArr = []
#randomly spawn three mushrooms on ready
func _ready():
	#randomize()
	var x = -200
	for i in 3:
		var newMush = mushroom.instance()
		newMush.set_position(Vector2(x, 375))
		add_child(newMush)
		mushArr.push_back(newMush)
		x += 200
	
	pass
	
#func _physics_process(delta):
#
#
#	pass
#
#
#func oneSleep():
#	for i in mushArr.size():
#		if mushArr[i].sleep == true:
#			Global.oneDown = true
#	pass
		
