# This node enables the text displayed on the pause button to change based on
# whether the timer is already paused.

extends TextureButton

var paused = false
var label  # The text on the pause button

# Executes when the pause button enters the scene for the first time
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

# Resets the label on the pause button to its default state
func resetText():
	checkNullLabel()
	label.text = 'Pause'

# This prevents the app from crashing if the label is referenced
# without being instantiated first
func checkNullLabel(): 
	if(label == null):
		label = $"PauseLabel"
