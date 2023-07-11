extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("p_right"):
        velocity.x += 1
    if Input.is_action_pressed("p_left"):
        velocity.x -= 1
    if Input.is_action_pressed("p_down"):
        velocity.y += 1
    if Input.is_action_pressed("p_up"):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)
