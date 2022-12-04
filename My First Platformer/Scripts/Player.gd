# 1 Extend the kinematic body node to allow for 2d physics
extends KinematicBody2D

# 2 Create a gravity variable of type int and set it to 800
# In capitals as it is a constant and won't change
var GRAVITY : int = 80

# 3 Create a variable to store the player velocity
# Set this to the type of a 2D vector e.g. x and y
var velocity: Vector2 = Vector2()
var speed: int = 10

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

	#velocity.x = 0
	# movement inputs
	if Input.is_action_pressed("player_left"):
		velocity.x -= speed
	elif Input.is_action_pressed("player_right"):
		velocity.x += speed
	else:
		velocity.x = 0

	if velocity.x < 0:
		sprite.flip_h = false
	elif velocity.x > 0:
		sprite.flip_h = true
	

	# 7 Create a variable for motion and update it each time the function is
	# called
	var motion = velocity * delta
	# 8 Call the move_and_collide funcion which moves the object
	# warning-ignore:return_value_discarded
	
	move_and_slide(velocity, Vector2.UP)
