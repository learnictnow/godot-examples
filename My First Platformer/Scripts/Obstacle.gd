extends RigidBody2D
const SCORE_MANAGER := preload("res://ScoreManager.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# 5 positions array to store Vector2 positions for the obstacle to move to.
# Set size to 1 for static obstacle, 2 for two positions, 3 for three positions etc.
# Position 0 will be the start position and set from the initial location in the scene
var locations = []
# 6 Target position index
var target_pos_index = 0
# 7 Variable to store the target position of the obstacle
var target_pos = global_position

# 13 Set the speed for the obstacle to move at
var speed = 25;

# Called when the node enters the scene tree for the first time.
func _ready():
	# 8 Add the starting position to the array
	locations.append(global_position)
	# 9 Set the target position to the starting position of the array
	target_pos = locations[0]
	
	# 10 Go through each node added as children of Waypoints and get the position
	for n in get_node("Waypoints").get_children():
		locations.append(n.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# 11 Call the local function that handles movement
	_move_around_locations(delta)
	
	pass

# 12 Function to move the obstacle around waypoints
func _move_around_locations(delta):
	# 15 Check if the obstacle is at the target position
	if position == target_pos:
		# 16 Get next position
		target_pos_index = target_pos_index + 1
		# 17 If next position falls off end of the array, reset to start of the array
		if target_pos_index + 1 > locations.size():
			target_pos_index = 0
		# 18 Update target position to new location
		target_pos = locations[target_pos_index]
		
	# 14 Move the obstacle towards the target position at set speed
	position = position.move_toward(target_pos, delta * speed)

func _on_KillArea_body_entered(body):
	# 1 Print hit message
	print("Obstacle hit player")
	# 2 Call the respawn function of the player (body) using dot notation
	body.respawn()

func _on_TopArea_body_entered(body):
	# 5 Run the score_points function and alloate 2 points
	body.score_points(2)
	
	# 3 Print message to test that a collision / overlap has been detected.
	print("Player hit top of obstacle")
	# 4 Queue free destroys the node / object
	queue_free()
	pass # Replace with function body.
