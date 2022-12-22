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
	# 5 Update the text on the screen
	text = "Score %s" % score
