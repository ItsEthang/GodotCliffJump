extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 1
const MAXSTRAFE = 80

var motion = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("P1Right"):
		motion.x = MAXSTRAFE
	elif Input.is_action_pressed("P1Left"):
		motion.x = -MAXSTRAFE
	else:
		motion.x = 0
	
