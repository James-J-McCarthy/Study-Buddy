extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# this code runs when MenuUpButton is pressed
func _on_texture_button_pressed():
	get_node("PhoneMover").play("PhoneUp")
	get_node("MenuUpButton").hide()

# this code runs when MenuBackButton is pressed
func _on_menu_back_button_pressed():
	get_node('PhoneMover').play("PhoneDown")
	get_node("MenuUpButton").show()
