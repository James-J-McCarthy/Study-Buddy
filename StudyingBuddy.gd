# This node controls the visibility of Buddy
extends Node2D


# _ready() method unused for this node
func _ready():
	pass

# _process(delta) method unused for this node
func _process(delta):
	pass


func hideBuddy():
	self.hide()
	
func showBuddy():
	self.show()


# shows Buddy when user starts the study session
func _on_start_button_pressed():
	showBuddy()
