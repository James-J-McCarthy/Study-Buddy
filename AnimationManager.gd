# This node chooses which animation will play next based on whether Buddy
# is studying or on break
extends Node

# A random number generator
var random = RandomNumberGenerator.new()
var TimeManager # TimeManager node reference

# Stores names for all the available Studying Animations
var studyingAnimation = PackedStringArray(["Writing", "Writing2", "Writing3", "Phone", "Writing", "Writing2", "Writing3", "Drink"])

# Stores names for all the available Break Animations
var breakAnimation = PackedStringArray(["Phone_5MIN"])

var buddyOnScreen = false # Whether Buddy is currently visible on-screen
var aniPlayer # Buddy's animation player

var blinkPlayer # Animation player for just blink
var blinkPause # The interval between this and the next blink
var blinkPauseCounter # The interval time that has elapsed since the last blink

# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager = get_parent().get_node("TimeManager")
	aniPlayer = get_node("../StudyingBuddySkeleton/StudyingBuddyAniPlayer")
	blinkPlayer = get_node("../StudyingBuddySkeleton/Blink AniPlayer")
	blinkPause = 5
	blinkPauseCounter = 0;

# called every frame
func _process(delta):
	if (blinkPauseCounter >= blinkPause):
		_blink()
		blinkPauseCounter = 0
		blinkPause = random.randi_range(10,20)
		print(blinkPause)
	blinkPauseCounter += delta

func _blink():
	print("Blinked")
	blinkPlayer.play("Blink")

func _rollIn():
	if (!buddyOnScreen):
		buddyOnScreen = true;
		aniPlayer.clear_queue()
		aniPlayer.play("Roll In")
		aniPlayer.queue("Idle")

func _rollOut():
	if (buddyOnScreen):
		buddyOnScreen = false;
		aniPlayer.clear_queue()
		aniPlayer.play("Roll Out")

# Return a random animation based on whether the buddy is studying.
# @Return: A string name of the animation
func _getAnimation() -> String:
	if TimeManager.getStudying() == true:
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
