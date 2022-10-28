extends RigidBody2D
# variables for vertical and horizontal speed
# exporting camera node path variable
export (NodePath) var camera_path
export (NodePath) var mushroom_path
export (NodePath) var mushroom2_path
export (NodePath) var mushroom3_path
var camera

var mushroom1Scene = preload ("res://instances/Mushroom1.tscn")
var mushroom2Scene = preload ("res://instances/Mushroom2.tscn")
var mushroom3Scene = preload ("res://instances/Mushroom3.tscn")

var mush1 = mushroom1Scene.instance()
var mush2 = mushroom2Scene.instance()
var mush3 = mushroom3Scene.instance()

var mushroom
var mushroom2
var mushroom3

#jump counts
var mushroom_jump_count = 0
var mushroom2_jump_count = 0
var mushroom3_jump_count = 0

#booleans for mushroom death
var mush1_death = false
var mush2_death = false
var mush3_death = false

# total collisions since death per mushroom 
var num_collisions_since_mush_death = 0
var num_collisions_since_mush2_death = 0
var num_collisions_since_mush3_death = 0
# grab the world scene
var world = 'res://scenes/World.tscn'

#player speeds
var jumpSpeed = 90
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
	mushroom = get_node(mushroom_path)
	mushroom2 = get_node(mushroom2_path)
	mushroom3 = get_node(mushroom3_path)
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	# grab the player's sprite
	sprite = get_node("Sprite")
	pass # Replace with function body.

# Physics Process: kind fo like window.requestAnimationFrame(delta)
func _physics_process(delta):
	# get action keys
	var leftKey = Input.is_action_pressed("ui_left")
	var rightKey = Input.is_action_pressed("ui_right")
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


func collision(body):
	
	if mush1_death:
		num_collisions_since_mush_death += 1
		if num_collisions_since_mush_death == 2:
			num_collisions_since_mush_death = 0
			mush1_death = false
			add_child(mush1)
	if mush2_death:
		num_collisions_since_mush2_death += 1
		if num_collisions_since_mush2_death == 2:
			num_collisions_since_mush2_death = 0
			mush2_death = false
			add_child(mush2)
	if mush3_death:
		num_collisions_since_mush3_death += 1
		if num_collisions_since_mush3_death == 2:
			num_collisions_since_mush3_death = 0
			mush3_death = false
			add_child(mush3)
	#if player collides with mushroom's area2D
	if body.is_in_group('mushrooms'):
		# increase mushroom jump count
		mushroom_jump_count += 1
		
		# reverse the vertical velocity
		set_linear_velocity(Vector2(0, -(get_linear_velocity().y)-jumpSpeed))
		$AnimationPlayer.play("jump")
		mushroom.play("Landed")
		if mushroom_jump_count == 3:
			mushroom.queue_free()
			mushroom_jump_count = 0
			mush1_death = true
		
			
	if body.is_in_group('mushrooms2'):
		#increase mushroom 2 jump count
		mushroom2_jump_count += 1
		
		# reverse the vertical velocity
		set_linear_velocity(Vector2(0, -(get_linear_velocity().y)-jumpSpeed))
		$AnimationPlayer.play("jump")
		mushroom2.play("Landed")
		if mushroom2_jump_count == 3:
			mushroom2.queue_free()
			mushroom2_jump_count = 0
			mush2_death = true
			
	if body.is_in_group('mushrooms3'):
		#increase mushroom 3 jump count
		mushroom3_jump_count += 1
		
		# reverse the vertical velocity
		set_linear_velocity(Vector2(0, -(get_linear_velocity().y)-jumpSpeed))
		$AnimationPlayer.play("jump")
		mushroom3.play("Landed")
		if mushroom3_jump_count == 3:
			mushroom3.queue_free()
			mushroom3_jump_count = 0
			mush3_death = true
			
	pass # Replace with function body.


func exit_screen():
	# avatar move out of frame
	if position.x > camera.position.x and get_linear_velocity().x > 0 :
		position = Vector2(-width/2 + 25, position.y)
	if position.x < camera.position.x and get_linear_velocity().x < 0:
		position = Vector2(width/2 - 25, position.y)
	#avatar falls out of frame, reset the world
	if position.y > (camera.position.y + height/2):
		get_tree().change_scene(world)
	pass # Replace with function body.
