extends TextureButton
var paused = false
var label

func _ready():
	label = $"PauseLabel"
	
# This function only updates the Label. 
func _on_pressed():
	checkNullLable()
	paused = !paused
	if(paused):
		label.text = 'Resume'
	else:
		label.text = 'Pause'

func resetText():
	checkNullLable()
	label.text = 'Pause'

func checkNullLable(): 
	if(label == null):
		print("Label Null Error!") # !!!!!!!!!!!!!!!!! debug line !!!!!!!!!!!!!!!
		label = $"PauseLabel"
