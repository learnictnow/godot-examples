extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_3_rd_person_pressed():
	print("3rd")
	get_tree().change_scene_to_file("res://examples/3D/player_3rd/Level_3rd_person.tscn")
	pass # Replace with function body.


func _on_button_fps_pressed():
	print("FPS")
	get_tree().change_scene_to_file("res://examples/3D/player_fps/Level_fps.tscn")
	pass # Replace with function body.


func _on_button_space_flight_pressed():
	print("Space")
	get_tree().change_scene_to_file("res://examples/3D/player_space/Level_space.tscn")
	pass # Replace with function body.


func _on_button_car_pressed():
	print("Car")
	get_tree().change_scene_to_file("res://examples/3D/player_vehicle/Level_vehicle.tscn")
	pass # Replace with function body.


func _on_button_point_and_click_pressed():
	print("RTS and Navmesh movement")
	get_tree().change_scene_to_file("res://examples/3D/player_point_and_click_movement/Level_Town.tscn")
	pass # Replace with function body.


func _on_button_2d_platformer_pressed():
	print("2D Platformer")
	get_tree().change_scene_to_file("res://examples/2D/player_2d_platformer/leve_2d_platformer.tscn")
	pass # Replace with function body.


func _on_button_3d_direction_movement_pressed():
	get_tree().change_scene_to_file("res://examples/3D/3D_Rotate_In_Direction/World.tscn")
	pass # Replace with function body.
	
func _on_button_test_environment_pressed():
	get_tree().change_scene_to_file("res://levels/test_environment/test_environment.tscn")
	pass # Replace with function body.
