extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var sprinting = false;

var platform = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var bullet_scene = preload("res://assets/models/bullet.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):	
	print(position)

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
		if Input.is_action_pressed("sprint"):
			velocity.z *= 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

	var platformVelocity = platform.velocity
	var displacement = platformVelocity * delta
	translation += displacement



#	var col = move_and_collide(velocity * delta)
#	if col:
#		print("I collided with ", col.get_collider().name)
#		if col.get_collider() is RigidBody3D:
#			col.get_collider().apply_central_impulse(-col.get_normal() * 5)
#			col.get_collider().apply_impulse(-col.get_normal() * 5, col.get_position())


func _input(event):
	
	if event is InputEventMouseMotion:

		var sensitivity = 1000

		rotation.y -= event.relative.x / sensitivity
		$CameraPivot.rotation.x -= event.relative.y / sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-90), deg_to_rad(90) )


		


	if Input.is_action_just_pressed("Fire"):
		spawn_bullet()

func spawn_bullet():
	var bullet_speed = 25
	
	var projectile = bullet_scene.instantiate() as RigidBody3D

	add_sibling(projectile)

	projectile.transform = $CameraPivot/BulletSpawn.global_transform
	projectile.linear_velocity = $CameraPivot/BulletSpawn.global_transform.basis.z * -1 * bullet_speed
