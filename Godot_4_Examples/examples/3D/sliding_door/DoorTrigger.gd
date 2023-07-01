extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_area_a_body_entered(body):
	print("A entered by " + body.name)
	if body.is_in_group("Player"):
		$Door/AnimationPlayer.play("door_open")
	pass # Replace with function body.


func _on_trigger_area_b_body_entered(body):
	print("B entered by " + body.name)
	if body.is_in_group("Player"):
		$Door/AnimationPlayer.play("door_close")
	pass # Replace with function body.
