extends RigidBody2D
# variables for vertical and horizontal speed
# exporting camera node path variable
export (NodePath) var camera_path
#export (NodePath) var mushroom_path

#var mushroom
var camera
# grab the world scene
var world = 'res://scenes/World.tscn'

#player speeds
var jumpSpeed = 400
var strafe = 0
var strafeAccel = 12.5
#avatar sprite
var sprite
# viewport dimensions
var width
var height
# all functions get called on start.

func _ready():
	camera = get_node(camera_path)
#	mushroom = get_node(mushroom_path)
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	# grab the player's sprite
	sprite = get_node("Sprite")
	pass # Replace with function body.

# Physics Process: kind fo like window.requestAnimationFrame(delta)
func _physics_process(delta):
	move()
	pass
	
func move():
	# get action keys
	var leftKey = Input.is_action_pressed("P1Left")
	var rightKey = Input.is_action_pressed("P1Right")
	var yVel = linear_velocity.y
	if yVel > 0:
		$AnimationPlayer.play("fall")
	if leftKey and !rightKey:
		# set x velocity, keep y velocity
		if strafe > 0:
			strafe = 0
		strafe -= strafeAccel
		# flip the sprite left
		sprite.set_flip_h(true)
		set_linear_velocity(Vector2(strafe, get_linear_velocity().y))
	if rightKey and !leftKey:
		if strafe < 0:
			strafe = 0
		strafe += strafeAccel
		# unflip the sprite(facing right)
		sprite.set_flip_h(false)
		set_linear_velocity(Vector2(strafe, get_linear_velocity().y))
	#if !leftKey and !rightKey:
	#	strafe = 0 
	#	set_linear_velocity(Vector2(strafe, get_linear_velocity().y))
	if (leftKey and rightKey) or (!leftKey and !rightKey):
		if (strafe > 0) : 
			strafe -= strafeAccel
			set_linear_velocity(Vector2(strafe, get_linear_velocity().y))
		if (strafe < 0) :
			strafe += strafeAccel
			set_linear_velocity(Vector2(strafe, get_linear_velocity().y))
	pass
	
	
func play(string) :
	$AnimationPlayer.play(string)
	pass
	
#reset all global vars
func resetGlobal() :
	Global.totalLanding = 0
	Global.end = false
	Global.numDown = 0
	pass

#detect if player moves out of frame
func exit_screen():
	# avatar move out of frame
	if position.x > camera.position.x and get_linear_velocity().x > 0 :
		position = Vector2(-width/2 + 25, position.y)
	if position.x < camera.position.x and get_linear_velocity().x < 0:
		position = Vector2(width/2 - 25, position.y)
	#avatar falls out of frame, reset the world
	if position.y > (camera.position.y + height/2):
		get_tree().change_scene(world)
		resetGlobal()
	pass # Replace with function body.

