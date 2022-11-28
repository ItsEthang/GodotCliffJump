extends RigidBody2D
# variables for vertical and horizontal speed
# exporting camera node path variable
export (NodePath) var camera_path
var camera
# grab the game over scene
const gameOver = 'res://scenes/gameOver1.tscn'

# grab pause screen
const pauseScreen = preload('res://scenes/PauseScreen.tscn')
#player speeds
var jumpSpeed = 500
var strafe = 0
var strafeAccel = 25
#avatar sprite
var sprite
# viewport dimensions
var width
var height

# all functions get called on start.
func _ready():
	camera = get_node(camera_path)
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
	var leftKey = Input.is_action_pressed("ui_left")
	var rightKey = Input.is_action_pressed("ui_right")
	var yVel = linear_velocity.y
	#play falling animation if if it is moving down
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
	
	
#check if player is out of frame
func exit_screen():
	# avatar move out of frame
	if position.x > camera.position.x and get_linear_velocity().x > 0 :
		position = Vector2(-width/2 + 25, position.y)
	if position.x < camera.position.x and get_linear_velocity().x < 0:
		position = Vector2(width/2 - 25, position.y)
	#avatar falls out of frame, reset the world
	if position.y > (camera.position.y + height/2):
		get_tree().change_scene(gameOver)
		resetGlobal()
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var pause_menu = pauseScreen.instance()
		add_child(pause_menu)
