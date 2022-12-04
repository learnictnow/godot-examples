# 1 Extend the kinematic body node to allow for 2d physics
extends KinematicBody2D

# 2 Create a gravity variable of type int and set it to 800
# In capitals as it is a constant and won't change
var GRAVITY : int = 80

# 3 Create a variable to store the player velocity
# Set this to the type of a 2D vector e.g. x and y
var velocity: Vector2 = Vector2()
# 7 Create a variable to set the speed of the player
# 20 Update the speed that the player moves
var speed : int = 50
# 14 Jump force
var jump : int = 50

# 4 Create a sprite variable and link it to the sprite node. When the node is
# initialised.
onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# 5 Runs the physics updates to the game
func _physics_process(delta):
	# 6 Update the y axis velocity by the time elapsed
	velocity.y += delta * GRAVITY

	# 8 Check is the left input is pressed
	# note player_left is the action in the input map
	if Input.is_action_pressed("player_left"):
		# 9 Update the velocity by the speed of the player
		# 18 set x velocity to -speed to have fixed speed
		velocity.x = -speed
	# 10 do the same for the moving right
	elif Input.is_action_pressed("player_right"):
		# 19 set x velocity to speed to have fixed speed
		velocity.x = speed
	# 11 If left or right is not pressed set the x velocity to 0
	else:
		velocity.x = 0

	# 12 Flip the sprite depending on the direction of movement
	if velocity.x < 0:
		sprite.flip_h = false
	elif velocity.x > 0:
		sprite.flip_h = true
	
	# 15 Detect the jump button being pressed
	# 17 Add the is_on_floor() check to the jump condition
	if Input.is_action_pressed("player_jump") && is_on_floor():
		# 16 Multiply by -1 to turn the velocity into a negative value
		velocity.y = jump * -1
	

	# 13 Move the object, the second parameter sets the vertical axis	
	move_and_slide(velocity, Vector2.UP)
