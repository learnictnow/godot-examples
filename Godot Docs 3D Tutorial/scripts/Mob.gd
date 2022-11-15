extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var min_speed = 10

export var max_speed = 18

var velocity = Vector3.ZERO

func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y((rand_range(-PI / 4, PI / 4)))
	
	var random_speed = rand_range(min_speed, max_speed)
	
	velocity = Vector3.FORWARD * random_speed
	
	velocity = velocity.rotated(Vector3.UP, rotation.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(_delta):
	move_and_slide(velocity)


func _on_VisibilityNotifier_screen_exited():
	queue_free()
