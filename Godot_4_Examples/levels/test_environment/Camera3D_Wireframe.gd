extends Camera3D


func _init():
	RenderingServer.set_debug_generate_wireframes(true)

#func _ready():
#	var vp = get_viewport()
#	vp.debug_draw = Viewport.DEBUG_DRAW_WIREFRAME;

#func _input(event):
#
#	if event is InputEventKey and Input.is_key_pressed(KEY_P):
#		var vp = get_viewport()
#		vp.debug_draw = (vp.debug_draw + 1 ) % 4
