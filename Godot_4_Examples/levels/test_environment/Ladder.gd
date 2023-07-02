extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ladder_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		print(str(self.get_index()) + " : Entered")
		
		body.manage_climbing(true)
	pass # Replace with function body.


func _on_ladder_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		print(str(self.get_index()) + " : Exited")
		body.manage_climbing(false)
		
		
	pass # Replace with function body.
