extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if TestEnvironmentGameManager.key_count <= 3:
		print("Here")
		process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		print("Portal entered")
		if TestEnvironmentGameManager.key_count >=3:
			print("Portal Active")
	pass # Replace with function body.
