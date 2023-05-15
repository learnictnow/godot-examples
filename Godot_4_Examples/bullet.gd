extends RigidBody3D

const BULLET_SPEED = 500

var bullet = null
var timer = null

func _ready():
	# Connect the timer to a function that will remove the bullet
	timer = Timer.new()
	timer.connect("timeout", self, "remove_bullet")
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func remove_bullet():
	# Remove the bullet from the scene
	if bullet != null:
		bullet.queue_free()
		bullet = null
