extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var climbing = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("CameraSwitch"):
		$Kiwi.visible = !$Kiwi.visible
		if $CameraPivot/FPSCamera3D.current:
			
			print("here")
			$CameraPivot/FPSCamera3D.current = false
			$"CameraPivot/3RDCamera3D".current = true
		else:
			print("now here")
			$CameraPivot/FPSCamera3D.current = true
			$"CameraPivot/3RDCamera3D".current = false
	
	
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:

		var sensitivity = 1000


		rotation.y -= event.relative.x / sensitivity
		$CameraPivot.rotation.x -= event.relative.y / sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-90), deg_to_rad(90) )

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
	if climbing:
		direction = (transform.basis * Vector3(input_dir.x, -input_dir.y, 0)).normalized()
	if direction:
		$Kiwi/AnimationPlayer.play("animationmodelwalk", 1)
		velocity.x = direction.x * SPEED
		if climbing:
			velocity.y = direction.y * SPEED
		velocity.z = direction.z * SPEED
	else:
		$Kiwi/AnimationPlayer.play("animationmodelidle", 1)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()





func _on_area_3d_area_entered(area):
	
	pass # Replace with function body.


func _on_area_3d_body_entered(body):
	#print("Something here")
	if body.is_in_group("Player"):
		print("Wall entered")
		climbing = true
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		print("Wall left")
		climbing = false
	pass # Replace with function body.
