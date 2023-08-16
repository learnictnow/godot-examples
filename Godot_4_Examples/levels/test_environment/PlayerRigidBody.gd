extends RigidBody3D

# not sure what to put here to get proper turning
var turn_speed = Vector3(1,0,0)

# not sure what to put here to get proper movement
var movement_speed = Vector3(1,0,0)

var jump_speed = Vector3(0,0,1)

# The direction in which to conduct a raycast to check for jumping
var floor_jump_dir = Vector3(0,1,0)

# jump_flag
var jump_enabled = true

const JUMP_RAYCAST_CHECK_RANGE = 10.0

# Add input action dependencies if not present
func _ready():
	if not InputMap.has_action("ui_left"):
		# add associated turn_left event
		InputMap.add_action("ui_left")
		var left_key = InputEventKey.new()
		left_key.set_scancode(KEY_LEFT)
		InputMap.action_add_event("ui_left",left_key)
	# do the same for all of the other actions mentioned in the
	# _integrate_forces method
	# this will ensure that all necessary actions and associated events EXIST
	# so long as at least one of these RigidbodyController3D scripts is used

# The documentation of Rigidbody advises against adding
# physics forces during _input, suggesting to use
# _integrate_forces instead.
# http://docs.godotengine.org/en/latest/classes/class_rigidbody.html#class-rigidbody-set-angular-velocity
func _integrate_forces(state):
	# Detect input and alter the state accordingly
	if Input.is_action_pressed("ui_left"):
		print("Left")
		state.set_angular_velocity(-turn_speed)
	if Input.is_action_pressed("ui_right"):
		print("Right")
		state.set_angular_velocity(turn_speed)
	if Input.is_action_pressed("ui_up"):
		print("Forward")
		state.set_linear_velocity(movement_speed)
	if Input.is_action_pressed("ui_down"):
		print("Back")
		state.set_linear_velocity(-movement_speed)
	if Input.is_action_pressed("ui_accept") and can_jump(state):
		print("Jumpy")
		state.set_linear_velocity(jump_speed)

func can_jump(state):
	# Use raycasting start at points surrounding the model,
	# pointed downwards to determine if ground is below.
	# Measure how far the rays go before they collide with anything.
	# Should be pretty short.
	# Can use enable_jump as a toggle
	# [self] is to preclude the raycast from hitting yourself
	var hit = state.get_space_state().intersect_ray(Vector3(),JUMP_RAYCAST_CHECK_RANGE * -floor_jump_dir, [self])
	if hit.size() == 0:
		return false
	if hit.collider.is_in_group("floor"):
		return true
	# if one wanted to do wall jumping, then they would need to raycast
	# in a different direction and check for a wall tag probably
	# Might even be more efficient to have a member variable on the collider
	# itself to check against. Especially if you have a lot of floors/walls
	# in a single level. Something like...
	# if hit.collider.can_jump_off_from():
	#     return true
	return false
