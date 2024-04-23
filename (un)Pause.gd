extends TextureButton
var paused = false

# This function only updates the Label. 
func _on_pressed():
	var label = $"Pause Label"
	paused = !paused
	if(paused):
		label.text = 'Play'
	else:
		label.text = 'Pause'


