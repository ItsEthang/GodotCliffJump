extends RigidBody2D
export (NodePath) var camera_path
var camera
var strafe = 0
var cnstSpd = 30
var random = RandomNumberGenerator.new()
var width
var timePassed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node(camera_path)
	width = get_viewport_rect().size.x
	random.randomize()
	strafe = random.randf_range(-150, 150)
	if strafe < 0:
		strafe -= cnstSpd
	if strafe > 0:
		strafe += cnstSpd
	set_linear_velocity(Vector2(strafe, 0))
	# set_linear_velocity(Vector2(0, 0))
	pass # Replace with function body.

func _physics_process(delta):
	#initialize random strafing velocity
	timePassed += delta;

	# randomize the strafing velocity again
	if timePassed >= 0.75:
		timePassed = 0
		random.randomize()
		strafe = random.randf_range(-200, 200)
		if strafe < 0:
			strafe -= cnstSpd
		if strafe > 0:
			strafe += cnstSpd
		set_linear_velocity(Vector2(strafe, 0))
		# set_linear_velocity(Vector2(0, 0))
	# print(strafe)
	pass
	
func play(string):
	$AnimationPlayer.play(string)
	pass
	


# so mushroom can teleport to the opposite side when going out of screen.
func exit_screen():
	if position.x > camera.position.x and get_linear_velocity().x > 0 :
		position = Vector2(-width/2 + 56, position.y)
	if position.x < camera.position.x and get_linear_velocity().x < 0:
		position = Vector2(width/2 - 56, position.y)
	pass # Replace with function body.
