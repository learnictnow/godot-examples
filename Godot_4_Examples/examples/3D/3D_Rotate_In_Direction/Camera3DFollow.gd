extends Camera3D

@onready var target = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(target.position,Vector3.UP)
	pass