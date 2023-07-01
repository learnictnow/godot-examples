extends Node2D

@onready var target = preload("res://2D_Spawn_And_Respawn/target.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawn():
	print("Spawn target")
	var random_number = randi_range(1,5)
	if random_number == 1:
		print(1)
		var t = target.instantiate()
		t.set_pos($SP1.position.x, $SP1.position.y)
		add_child(t)
	if random_number == 2:
		print(2)
		var t = target.instantiate()
		t.set_pos($SP2.position.x, $SP1.position.y)
		add_child(t)
	if random_number == 3:
		print(3)
		var t = target.instantiate()
		t.set_pos($SP3.position.x, $SP1.position.y)
		add_child(t)
	if random_number == 4:
		print(4)
		var t = target.instantiate()
		t.set_pos($SP4.position.x, $SP1.position.y)
		add_child(t)
	if random_number == 5:
		print(5)
		var t = target.instantiate()
		t.set_pos($SP5.position.x, $SP1.position.y)
		add_child(t)
	pass
