extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_KillArea_body_entered(body):
	# 1 Print hit message
	print("Obstacle hit player")
	# 2 Call the respawn function of the player (body) using dot notation
	body.respawn()


func _on_Obstacle_body_entered(body):
	print("Player hit top of obstacle")
	pass # Replace with function body.
