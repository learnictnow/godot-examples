extends Node3D

@onready var _follow :PathFollow3D = get_parent()
var _speed :float = 10.0

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)
