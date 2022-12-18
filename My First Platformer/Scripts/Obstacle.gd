extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# 5 positions array to store Vector2 positions for the obstacle to move to.
# Set size to 1 for static obstacle, 2 for two positions, 3 for three positions etc.
# Position 0 will be the start position and set from the initial location in the scene
var locations = []
# 6 Target position index
var target_pos_index = 0
var target_pos = global_position

var velocity = Vector2()
var speed = 25;

# Called when the node enters the scene tree for the first time.
func _ready():
	# 7 Set the size of the array
	#locations = new Vector2[num_positions]
	locations.append(global_position)
	target_pos = locations[0]
	
	for n in get_node("Positions").get_children():
		locations.append(n.global_position)
	
	print(locations)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move_around_locations(delta)
	
	pass

func _move_around_locations(delta):
	if position == target_pos:
		# get next position
		target_pos_index = target_pos_index + 1
		
		if target_pos_index + 1 > locations.size():
			target_pos_index = 0
		target_pos = locations[target_pos_index]
		print(position)
	position = position.move_toward(target_pos, delta * speed)

func _on_KillArea_body_entered(body):
	# 1 Print hit message
	print("Obstacle hit player")
	# 2 Call the respawn function of the player (body) using dot notation
	body.respawn()

func _on_TopArea_body_entered(body):
	# 3 Print message to test that a collision / overlap has been detected.
	print("Player hit top of obstacle")
	# 4 Queue free destroys the node / object
	queue_free()
	pass # Replace with function body.
