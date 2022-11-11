extends RigidBody2D
export (NodePath) var camera_path
var camera
var strafe = 0
var cnstSpd = 30
var random = RandomNumberGenerator.new()
var width
var timePassed = 0
#track landing times
var landed = 0
#sleep after three landings
var sleep = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle1")
	camera = get_node(camera_path)
	width = get_viewport_rect().size.x
	random.randomize()
	strafe = random.randf_range(-150, 150)
	if strafe < 0:
		strafe -= cnstSpd
	if strafe > 0:
		strafe += cnstSpd
	set_linear_velocity(Vector2(strafe, 0))
	#set_linear_velocity(Vector2(0, 0))
	pass # Replace with function body.

func _physics_process(delta):
	#initialize random strafing velocity
	
	timePassed += delta;

	# randomize the strafing velocity again
	if timePassed >= 0.75:
		timePassed = 0
		random.randomize()
		strafe = random.randf_range(-150, 150)
		if strafe < 0:
			strafe -= cnstSpd
		if strafe > 0:
			strafe += cnstSpd
		set_linear_velocity(Vector2(strafe, 0))
		#set_linear_velocity(Vector2(0, 0))
	# print(strafe)
	pass
	
func play(string):
	$AnimationPlayer.play(string)
	pass
	
func stop():
	$AnimationPlayer.stop()
	pass
	


# so mushroom can teleport to the opposite side when going out of screen.
func exit_screen():
	if position.x > camera.position.x and get_linear_velocity().x > 0 :
		position = Vector2(-width/2 + 56, position.y)
	if position.x < camera.position.x and get_linear_velocity().x < 0:
		position = Vector2(width/2 - 56, position.y)
	pass # Replace with function body.

	
func Landed():
	#platform animation change
	#print('player contact')
	if landed == 0:
		$AnimationPlayer.play("Landed")
	if landed == 1:
		$AnimationPlayer.play("Landed2")
	if landed == 2:
		$AnimationPlayer.play("Landed3")
		sleep = true
		#set collision mask and layer to false
		#so collsion is not longer valid
		set_collision_mask_bit(0, false)
		set_collision_layer_bit(0, false)
	#increase landing
	landed += 1
	pass


func _on_Area2D_body_entered(body):
	#triggers when player's hitbox hits mushroom's area 2D
	if body.is_in_group('player'):
		print('jump!')
		body.play('jump')
		set_linear_velocity(Vector2(get_linear_velocity().x, 0))
		if !sleep:
			body.set_linear_velocity(Vector2(0, -500))
			Landed()
	pass # Replace with function body.
