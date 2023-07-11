extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
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

	move_and_slide()
#
#	if Input.is_action_just_pressed("ui_left"):
#		#$body.rotate(Vector3.UP, deg_to_rad(90))
#		$body.look_at(transform.origin + Vector3.LEFT, Vector3.UP)
#	elif Input.is_action_just_pressed("ui_up"):
#		$body.look_at(transform.origin + Vector3.FORWARD, Vector3.UP)
#	elif Input.is_action_just_pressed("ui_right"):
#		$body.look_at(transform.origin + Vector3.RIGHT, Vector3.UP)
#	elif Input.is_action_just_pressed("ui_down"):
#		$body.look_at(transform.origin + Vector3.BACK, Vector3.UP)

func _input(event):
	if event.is_action_pressed("Fire"):
		print("Fire")