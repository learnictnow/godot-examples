extends Area2D

signal target_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("signal_name", <target_node>, "target_method_name")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body.name, " entered")
	pass # Replace with function body.
