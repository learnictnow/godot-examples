extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var anim_play = $CameraPivot/Camera3D/AnimationPlayer

#var bullet_scene = preload("res://bullet.tscn")

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


	if direction != Vector3():
		anim_play.play("head_bobbing")


#	var col = move_and_collide(velocity * delta)
#	if col:
#		print("I collided with ", col.get_collider().name)
#		if col.get_collider() is RigidBody3D:
#			col.get_collider().apply_central_impulse(-col.get_normal() * 5)
#			col.get_collider().apply_impulse(-col.get_normal() * 5, col.get_position())


func _input(event):
	if event is InputEventMouseMotion:

		var sensitivity = 1000

#		rotation.y -= event.relative.x / sensitivity
#
#		var camera_rotation = $CamAnchor.rotation
#		camera_rotation.x -= event.relative.y / sensitivity
#		camera_rotation.y -= event.relative.x / sensitivity
#		camera_rotation.x = clamp(camera_rotation.x, deg_to_rad(-45), deg_to_rad(90))
#		$CamAnchor.rotation = camera_rotation

		rotation.y -= event.relative.x / sensitivity
		$CameraPivot.rotation.x -= event.relative.y / sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-90), deg_to_rad(90) )
#		mouse_relative_x = clamp(event.relative.x, -50, 50)
#		mouse_relative_y = clamp(event.relative.y, -50, 10)

		#look_at($CamAnchor.global_position, Vector3.UP)
		#var camera_rotation2 = $CamAnchor.global_transform.basis.get_euler()
		#global_rotation = camera_rotation2

		


	if Input.is_action_just_pressed("Fire"):
		print("fire")
		#spawn_bullet()
		#var bullet = bullet_scene.instantiate()




