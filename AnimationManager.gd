extends Node

var studyingAnimation = ["Writing", "Writing2"]
var breakAnimation = ["Phone"]
var transitionAnimation = []
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _getAnimation():
	if get_node("TimeManager").getStudying():
		_getStudyingAnimation()
	else:
		_getBreakAnimation()


func _getStudyingAnimation():
	var animation = random.randi_range(0, studyingAnimation.length())
	return studyingAnimation[animation]
	
func _getBreakAnimation():
	var animation = random.randi_range(0, breakAnimation.length())
	return breakAnimation[animation]
