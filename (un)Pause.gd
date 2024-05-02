extends TextureButton

var paused = false
var label

func _ready():
	label = $"PauseLabel"

# This function only updates the label on the pause button when it is pressed
func _on_pressed():
	checkNullLabel()
	paused = !paused
	if (paused):
		label.text = 'Resume'
	else:
		label.text = 'Pause'

func resetText():
	checkNullLabel()
	label.text = 'Pause'

# This prevents the app from crashing if the label is referenced
# without being instantiated first
func checkNullLabel(): 
	if(label == null):
		label = $"PauseLabel"
