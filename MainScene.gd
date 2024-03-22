extends Node2D

var studying = true

signal start_timer


# Called when the node enters the scene tree for the first time.
func _ready():
	start_timer.emit()
	_studying_buddy_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _studying_buddy_animation():
	if studying:
		get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").play("Writing")
	
# this code runs when MenuUpButton is pressed
func _on_texture_button_pressed():
	get_node("PhoneMover").play("PhoneUp")
	get_node("MenuUpButton").hide()

# this code runs when MenuBackButton is pressed
func _on_menu_back_button_pressed():
	get_node('PhoneMover').play("PhoneDown")
	get_node("MenuUpButton").show()
