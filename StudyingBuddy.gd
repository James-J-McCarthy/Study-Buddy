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
	get_node("ArmR").show()
	get_node("Tail").show()
	get_node("Torso").show()
	get_node("Desk CoverUp").show()
	get_node("Head").show()
	get_node("Nose").show()
	get_node("Closed Eye").hide()
	get_node("PhoneOnHand").hide()
	get_node("Pen").show()
	get_node("ArmL").show()
	get_node("Mug").show()


# shows Buddy when user starts the study session
func _on_start_button_pressed():
	showBuddy()
