extends RigidBody3D


@export var jump_velocity = 10
@export var accelleration = 5
var accel_multiplier = 1.0
@export var speed = 25
@export var max_speed = 50
@export var stop_speed = 0.1

var climbing = false
var can_sprint = true

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if $CameraPivot/FPSCamera3D.current:
		$Model.visible = false
		

func _input(event):
	if event.is_action_pressed("CameraSwitch"):
		$Model.visible = !$Model.visible
		if $CameraPivot/FPSCamera3D.current:
			$CameraPivot/FPSCamera3D.current = false
			$"CameraPivot/3RDCamera3D".current = true
		else:
			$CameraPivot/FPSCamera3D.current = true
			$"CameraPivot/3RDCamera3D".current = false
	
	if event.is_action_pressed("model_switch"):
		if $Model/Kiwiblock.visible:
			$Model/Kiwiblock.visible = false
			$Model/Kiwiround.visible = true
		else:
			$Model/Kiwiblock.visible = true
			$Model/Kiwiround.visible = false
	
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:

		var sensitivity = 1000


		rotation.y -= event.relative.x / sensitivity
		$CameraPivot.rotation.x -= event.relative.y / sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-90), deg_to_rad(90) )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		print("Up pressed")
		apply_impulse(Vector3.FORWARD, position)
	if Input.is_action_pressed("ui_down"):
		print("Up pressed")
		apply_impulse(Vector3.BACK, position)
	if Input.is_action_pressed("ui_accept"):
		print("Up pressed")
		apply_impulse(Vector3.UP, position)
	pass

#func look_follow(state, current_transform, target_position):
#	var up_dir = Vector3(0, 1, 0)
#	var cur_dir = current_transform.basis * Vector3(0, 0, 1)
#	var target_dir = (target_position - current_transform.origin).normalized()
#	var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)
#
#	state.angular_velocity = up_dir * (rotation_angle / state.step)
#
#func _integrate_forces(state):
#	var target_position = $my_target_node3d_node.global_transform.origin
#	look_follow(state, global_transform, target_position)

func manage_climbing(is_climbing: bool):
	climbing = is_climbing
	if climbing:
		pass
		#gravity = 0
	else:
		pass
		#gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _on_sprint_timer_timeout():
	can_sprint = true
	print("can_sprintSprint reset")
	pass # Replace with function body.
