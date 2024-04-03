extends HSlider
# This script is here to help the slider update the lable which displays the 
# slider value


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_value_changed(value):
	$SessionTimeReadout.set_text(str(value)) # This line tells the readout label to update 
