#extends RigidBody2D
extends Area2D

# 5 Create a signal to handle detecting the player being hit
signal player_hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	# 1 Get an array of bodies that the obstacle has collided with
#	var bodies = get_colliding_bodies()
#	# 2 go through the array of bodies
#	for body in bodies:	
#		# 3 Check if the body has the name Player
#		if body.name == "Player":
#			# 4 print the message hit player if the body hit was player
#			#print("Hit player")
#			# 6
#			emit_signal("player_hit")


func _on_KillArea_body_entered(body):
	print("Obstacle Hit player")
	body.respawn()
	pass # Replace with function body.
