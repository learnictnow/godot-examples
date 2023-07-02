extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area3D.rotation.x = randi_range(0,360)
	$Area3D.rotation.y = randi_range(0,360)
	$Area3D.rotation.z = randi_range(0,360)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		print(body.name)
		TestEnvironmentGameManager.key_count += 1
		print("Keys: " + str(TestEnvironmentGameManager.key_count))
		if TestEnvironmentGameManager.key_count >= 3:
			get_parent_node_3d().activate_exit()
		queue_free()
	pass # Replace with function body.
