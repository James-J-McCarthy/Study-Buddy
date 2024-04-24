extends TextureButton
var paused = false

# This function only updates the Label. 
func _on_pressed():
	var label = $"Pause Label"
	paused = !paused
	if(paused):
		label.text = 'Resume'
	else:
		label.text = 'Pause'

func resetText():
	var label = $"Pause Label"
	label.text = 'Pause'
