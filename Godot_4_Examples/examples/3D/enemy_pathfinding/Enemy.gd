extends CharacterBody3D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@export var movement_target_node: Node3D
@export var waypoints: Array
var movement_target_position: Vector3 = Vector3(100.0,0.0,-100.0)
var waypointIndex = 0

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	waypoints = get_tree().get_nodes_in_group("Waypoints")
	#movement_target_position = movement_target_node.position
	navigation_agent.set_target_position(waypoints[waypointIndex].global_position)
	# Make sure to not await during _ready.


func _physics_process(delta):
	
	if navigation_agent.is_navigation_finished():
		waypointIndex += 1
		if waypointIndex > waypoints.size() -1:
			waypointIndex = 0
		navigation_agent.set_target_position(waypoints[waypointIndex].global_position)
#	

	var current_agent_position: Vector3 = global_transform.origin
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	var new_velocity: Vector3 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	set_velocity(new_velocity)
	move_and_slide()


func _on_vision_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		print("Chase!!!")
		navigation_agent.set_target_position(body.position)
	pass # Replace with function body.


func _on_vision_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		print("Stop Chase!!!")
		waypointIndex += 1
		if waypointIndex > waypoints.size() -1:
			waypointIndex = 0
		navigation_agent.set_target_position(waypoints[waypointIndex].global_position)
	pass # Replace with function body.
