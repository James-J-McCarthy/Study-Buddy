extends Label
# This script is here to help the slider update the label which displays the 
# slider value


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_break_time_slider_value_changed(value):
	set_text(str(value)) # This line tells the readout label to update
