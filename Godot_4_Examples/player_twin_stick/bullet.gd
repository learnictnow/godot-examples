extends RigidBody3D

const BULLET_SPEED = 5

func remove_bullet():
	queue_free()


func _on_body_entered(body):
	print("Boom headshot!!!!")
	# Broadcast signal
	pass # Replace with function body.


func _on_timer_timeout():
	print("Timeout")
	remove_bullet()
