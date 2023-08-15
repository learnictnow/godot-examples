extends Label

# 1 Set the score to 0
var score = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# 2 Display the initial score
	text = "Score %s" % score
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# 3 Create the function to score points, the parameter is the number of points to add
func score_points(points):
	# 4 updates the score variable
	score = score + points
	
	# 6 Check if there are enough points
	if score >= 5:
		# 7 display the button, we need to get the parent node and then the button as this is at the same level in the scene
		get_parent().get_node("Button").visible = true
		# 8 Pause the game
		get_tree().paused = true
	
	# 5 Update the text on the screen
	text = "Score %s" % score


func _on_Button_pressed():
	#10 Unpause the game
	get_tree().paused = false
	# 9 Load the main menu scene
	get_tree().change_scene("res://MainMenu.tscn")
	pass # Replace with function body.
