# This node chooses which animation will play next based on whether Buddy
# is studying or on break
extends Node

# A random number generator
var random = RandomNumberGenerator.new()
var timeManager

# Stores names for all the available Studying Animations
var studyingAnimation = PackedStringArray(["Writing", "Writing2", "Phone", "Writing", "Writing2"])

# Stores names for all the available Break Animations
var breakAnimation = PackedStringArray(["Phone_5MIN"])


# Called when the node enters the scene tree for the first time.
func _ready():
	timeManager = get_parent().get_node("TimeManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Return a random animation based on whether the buddy is studying.
# @Return: A string name of the animation
func _getAnimation() -> String:
	if timeManager.getStudying() == true:
		return _getStudyingAnimation()
	else:
		return _getBreakAnimation()

# Return a random studying animation.
func _getStudyingAnimation() -> String:
	var animation : int = random.randi_range(0, studyingAnimation.size()-1)
	var result : String = studyingAnimation[animation]
	return result

# Return a random break animation.
func _getBreakAnimation() -> String:
	var animation : int = random.randi_range(0, breakAnimation.size()-1)
	var result : String = breakAnimation[animation]
	return result
