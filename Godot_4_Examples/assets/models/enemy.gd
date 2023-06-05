extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rigid_body_3d_body_entered(body):
	print("Test")
	if body.is_in_group("Projectiles"):
		queue_free()


func _on_detection_area_3d_body_entered(body):
	print("Enemy has seen " + body.name)
	if body.is_in_group("Player"):
		print("Player ground found")
		get_tree().change_scene_to_file("res://test_level/test_level_blockbench_animation.tscn")
		$DetectionArea3D/MeshInstance3D/AnimationPlayer.play("enemy_detected")
	pass # Replace with function body.


func _on_detection_area_3d_body_exited(body):
	print("Enemy has lost " + body.name)
	if body.is_in_group("Player"):
		$DetectionArea3D/MeshInstance3D/AnimationPlayer.play("idle")
	pass # Replace with function body.
