extends Node2D

var studying = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$StudyingBuddy.hide()
	$MenuUpButton.hide()
	await get_tree().create_timer(1.25).timeout # delay phone open animation by 1.25 seconds when app opens
	$MenuUpButton.show()
	_on_menu_up_button_pressed()
	_on_settings_button_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _studying_buddy_animation():
	get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").play($AnimationManager._getAnimation())


# this code runs when MenuUpButton is pressed
func _on_menu_up_button_pressed():
	get_node("PhoneMover").play("PhoneUp")
	get_node("MenuUpButton").hide()
	get_node("Phone").get_node("MusicScreen").hide()
	get_node("Phone").get_node("SettingsScreen").hide()
	get_node("Phone").get_node("AppScreen").show()

# this code runs when MenuBackButton is pressed
func _on_menu_back_button_pressed():
	get_node("PhoneMover").play("PhoneDown")
	get_node("MenuUpButton").show()

# this code runs when MessagesButton is pressed
func _on_messages_button_pressed():
	get_node("Phone").get_node("AppScreen").hide()
	get_node("Phone").get_node("MusicScreen").show()

# this code runs when SettingsButton is pressed from app screen
func _on_settings_button_pressed():
	# node variables:
	var timeManager = get_node("TimeManager")
	var phone = get_node("Phone")
	var settingsScreen = $settingsScreen
	var settingsBackButton = get_node("Phone/SettingsScreen/SettingsBackButton")
	
	# shows the appropraite settings screen if session is running or not
	if ((timeManager) != null && timeManager.get_session_running()):
		phone.get_node("AppScreen").hide()
		phone.get_node("MidSessionSettings").show()

	else:
		phone.get_node("AppScreen").hide()
		phone.get_node("SettingsScreen").show()


# runs when mid-session settings screen back button is pressed
func _on_settings_back_button_2_pressed():
	get_node("Phone").get_node("MidSessionSettings").hide()
	get_node("Phone").get_node("AppScreen").show()	
	
# this code runs when MessagesBackButton is pressed
func _on_messages_back_button_pressed():
	get_node("Phone").get_node("MusicScreen").hide()
	get_node("Phone").get_node("AppScreen").show()


func _on_start_button_pressed():
	_on_menu_back_button_pressed()
	get_node("StudyingBuddy").show()
	var animation:String = get_node("AnimationManager")._getAnimation()
	get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").play(animation)

func _on_studying_buddy_ani_player_animation_started(anim_name):
	if (anim_name == "Idle"):
		print("Idle Now, queuing:")
		var animation:String = get_node("AnimationManager")._getAnimation()
		print(animation)
		get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").queue(animation)
	else:
		get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").queue("Idle")
		print("Queuing Idle")
	

# this kicks the user off the mid-session-settings screen
func _on_end_session_pressed():
	var phone = get_node("Phone")
	
	get_node("StudyingBuddy").hide()
	_on_settings_back_button_2_pressed()
	phone.get_node("AppScreen").hide()
	phone.get_node("SettingsScreen").show()
