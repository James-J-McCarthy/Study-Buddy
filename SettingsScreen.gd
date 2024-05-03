# This script manages what happens on the settings screen
extends Sprite2D
var studySlider
var studySliderReadout
var breakSlider
var breakSliderReadout
var cycleSlider
var cycleSliderReadout
var timeManager


# Called when the node enters the scene tree for the first time.
func _ready():
	studySlider = get_node("StudyTimeSlider")
	studySliderReadout = studySlider.get_node("StudyTimeReadout")
	breakSlider = get_node("BreakTimeSlider")
	breakSliderReadout = breakSlider.get_node("BreakTimeReadout")
	cycleSlider = get_node("CyclesSlider")
	cycleSliderReadout = cycleSlider.get_node("CyclesReadout")
	timeManager = get_node("../../TimeManager")

func getStudyTime():
	return studySlider.value

func getBreakTime():
	return breakSlider.value

func getCyclesTotal():
	return cycleSlider.value



func _on_break_time_slider_value_changed(value):
	breakSliderReadout.set_text(str(value)) 

func _on_study_time_slider_value_changed(value):
	studySliderReadout.set_text(str(value))

func _on_cycles_slider_value_changed(value):
	pass # Replace with function body.
