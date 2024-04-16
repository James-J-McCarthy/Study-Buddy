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

func _on_start_button_pressed():
	_on_menu_back_button_pressed()
	var animation:String = get_node("AnimationManager")._getAnimation()
	get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").play(animation)


func _on_reset_button_pressed():
	_on_menu_back_button_pressed()


func _on_studying_buddy_ani_player_animation_started(anim_name):
	if (anim_name == "Idle"):
		print("Idle Now, queuing:")
		var animation:String = get_node("AnimationManager")._getAnimation()
		print(animation)
		get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").queue(animation)
	else:
		get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer").queue("Idle")
		print("Queuing Idle")
	
