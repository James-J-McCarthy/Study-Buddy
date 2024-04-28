# This script manages what happens on the settings screen
extends Sprite2D
var studySlider
var breakSlider
var cycleSlider
var timeManager


# Called when the node enters the scene tree for the first time.
func _ready():
	studySlider = get_node("StudyTimeSlider")
	breakSlider = get_node("BreakTimeSlider")
	cycleSlider = get_node("CyclesSlider")
	timeManager = get_node("../../TimeManager")
func getStudyTime():
	return studySlider.value

func getBreakTime():
	return breakSlider.value

func getCyclesTotal():
	return cycleSlider.value

