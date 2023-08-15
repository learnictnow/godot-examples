extends Node3D

@export var TargetScene: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	print(str(body, " entered"))
	
	var scene_location = "res://GameManagerExample/Room" + TargetScene + ".tscn"
	get_tree().change_scene_to_file(scene_location)
	
	#get_tree().change_scene_to_file("res://GameManagerExample/RoomD.tscn")
	pass # Replace with function body.
