extends Node3D

var mouse_sensitivity = 0.1
var pitch = 0.0

func _input(event):
	if event is InputEventMouseMotion:
		var camera_rotation = global_transform.basis.get_euler()
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-70), deg_to_rad(80))
		camera_rotation.x = -pitch
		camera_rotation.y -= event.relative.x * mouse_sensitivity
		global_transform.basis = Basis().from_euler(camera_rotation)
