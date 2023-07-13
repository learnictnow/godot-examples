extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var bullet_scene = preload("res://assets/models/bullet.tscn")

@export var sensitivity = 1000

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
	#var direction = ($CamAnchor.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:

		rotation.y -= event.relative.x / sensitivity
		$CameraPivot.rotation.x -= event.relative.y / sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-90), deg_to_rad(90) )


	if Input.is_action_just_pressed("Fire"):
		print("fire")
		#spawn_bullet()
		#var bullet = bullet_scene.instantiate()




func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	#add_child(bullet)

	add_sibling(bullet)

	bullet.transform = $BulletSpawn.global_transform


	#bullet.apply_central_impulse(Vector3(0, 0, bullet_speed))
	var bullet_speed = 5
	#bullet.linear_velocity = Vector3(0, 0, bullet_speed)

