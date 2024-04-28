extends TextureButton
var paused = false
var label

func _ready():
	label = $"PauseLabel"
	
# This function only updates the Label. 
func _on_pressed():
	paused = !paused
	if(paused):
		label.text = 'Resume'
	else:
		label.text = 'Pause'

func resetText():
	label.text = 'Pause'
