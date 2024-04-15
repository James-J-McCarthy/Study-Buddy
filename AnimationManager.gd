extends Node

var studyingAnimation = PackedStringArray(["Writing", "Writing2"])
var breakAnimation = ["Phone"]
var transitionAnimation = []
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _getAnimation() -> String:
	if get_parent().get_node("TimeManager").getStudying() == true:
		return _getStudyingAnimation()
	else:
		return _getBreakAnimation()


func _getStudyingAnimation() -> String:
	var animation : int = random.randi_range(0, studyingAnimation.size()-1)
	var result : String = studyingAnimation[animation]
	return result
	
func _getBreakAnimation() -> String:
	var animation : int = random.randi_range(0, breakAnimation.size()-1)
	var result : String = breakAnimation[animation]
	return result
