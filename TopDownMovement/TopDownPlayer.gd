extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed : int = 25
var velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _physics_process(delta):
	var move_vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	velocity = move_vector.clamped(1) * speed
	#velocity = move_vector * speed
	velocity = move_and_slide(velocity)
	print(velocity)
	#sprite.rotation = velocity.Angle();
	look_at(get_global_mouse_position())
