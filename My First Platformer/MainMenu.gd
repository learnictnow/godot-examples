extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	# 1 Get the tree of nodes for the project and change the scene to the one at the location.
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_ExitButton_pressed():
	# 2 Quit the program when the button is pressed.
	get_tree().quit()
