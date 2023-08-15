extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func death():
	GameManager.lives = GameManager.lives - 1

func _process(delta):
	$Control/SubViewportContainer/SubViewport/Camera3D.global_transform.origin = $MiniMapCameraPos.global_transform.origin
	$Control/SubViewportContainer/SubViewport/Camera3D.global_transform.basis.x = $MiniMapCameraPos.global_transform.basis.x
	pass

func _physics_process(delta):
	GameManager.lives = GameManager.lives - 1
	print(GameManager.lives)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	print(velocity)

#	move_and_slide()
#
#	velocity += get_platform_velocity()
#
	move_and_slide()
	
#	move_and_slide_with_snap()
	
	#print(velocity)
	
	
