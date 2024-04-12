extends Node2D

var studying = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	_studying_buddy_animation()
	var tm = $TimeManager
	
	tm.initializeClockLabelText()
	tm.set_study_time(get_node("Phone/SettingsScreen/StudyTimeSlider").value)
	tm.set_break_time(get_node("Phone/SettingsScreen/BreakTimeSlider").value)
	tm.start_study_timer()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _studying_buddy_animation():
	get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").play("Writing")


# this code runs when MenuUpButton is pressed
func _on_menu_up_button_pressed():
	get_node("PhoneMover").play("PhoneUp")
	get_node("MenuUpButton").hide()
	get_node("Phone").get_node("MessagesScreen").hide()
	get_node("Phone").get_node("SettingsScreen").hide()
	get_node("Phone").get_node("AppScreen").show()

# this code runs when MenuBackButton is pressed
func _on_menu_back_button_pressed():
	get_node("PhoneMover").play("PhoneDown")
	get_node("MenuUpButton").show()

# this code runs when MessagesButton is pressed
func _on_messages_button_pressed():
	get_node("Phone").get_node("AppScreen").hide()
	get_node("Phone").get_node("MessagesScreen").show()

# this code runs when SettingsButton is pressed
func _on_settings_button_pressed():
	get_node("Phone").get_node("AppScreen").hide()
	get_node("Phone").get_node("SettingsScreen").show()

# this code runs when MessagesBackButton is pressed
func _on_messages_back_button_pressed():
	get_node("Phone").get_node("MessagesScreen").hide()
	get_node("Phone").get_node("AppScreen").show()

# this code runs when SettingsBackButton is pressed
func _on_settings_back_button_pressed():
	get_node("Phone").get_node("SettingsScreen").hide()
	get_node("Phone").get_node("AppScreen").show()
