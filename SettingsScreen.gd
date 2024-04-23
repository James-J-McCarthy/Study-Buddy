# This script manages what happens on the settings screen
extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func getStudyTime():
	return get_node("StudyTimeSlider").value

func getBreakTime():
	return get_node("BreakTimeSlider").value

func getCyclesTotal():
	return get_node("CyclesSlider").value


# Resets sliders if time interval settings aren't confirmed with ResetButton
# or StartButton
func _on_settings_back_button_pressed():
	if (!$StartButton.visible):
		$StudyTimeSlider.value = get_parent().get_parent().get_node("TimeManager").get_study_time()
		$BreakTimeSlider.value = get_parent().get_parent().get_node("TimeManager").get_break_time()
		$CyclesSlider.value = get_parent().get_parent().get_node("TimeManager").get_cycles_total()

