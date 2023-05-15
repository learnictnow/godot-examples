extends Camera3D

@export var target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	if target:
		var target_position = target.global_transform.origin
		look_at(target_position, Vector3.UP)
		#global_transform.basis = target_rotation.basis
