extends Node3D

var timer = 0.00

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	print("Time: %.2f" %timer)
	$UI/Label.text = "Time: %.2f" %timer
	
	if timer >= 10:
		get_tree().quit()
		
	
	pass


func _on_timer_timeout():
	
	pass # Replace with function body.


func _on_end_point_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().paused = true
	pass # Replace with function body.
