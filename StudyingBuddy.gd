extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hideBuddy():
	self.hide()
	
func showBuddy():
	self.show()

func _on_start_button_pressed():
	showBuddy()
