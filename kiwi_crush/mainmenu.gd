extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://level.tscn")
	pass # Replace with function body.
