# This script manages the elements on on the settings screen
extends Sprite2D

var studySlider # Slider setting study interval duration
var studySliderReadout # Readout display of current study interval duration setting
var breakSlider # Slider setting break interval duration
var breakSliderReadout # Readout display of current break interval duration setting
var cycleSlider # Slider setting number of study cycles
var cycleSliderReadout # Readout display of current setting for number of study cycles
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


# State getters below
func getStudyTime():
	return studySlider.value

func getBreakTime():
	return breakSlider.value

func getCyclesTotal():
	return cycleSlider.value


# The following three functions update the value readout next to
# each of the respective settings sliders when the slider values are
# changed from their defaults
func _on_break_time_slider_value_changed(value):
	breakSliderReadout.set_text(str(value)) 

func _on_study_time_slider_value_changed(value):
	studySliderReadout.set_text(str(value))

func _on_cycles_slider_value_changed(value):
	cycleSliderReadout.set_text(str(value))
