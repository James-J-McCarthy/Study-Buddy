
extends Node2D

var Phone # Phone node reference
var studying = true
var TimeManager # TimeManager node reference
var AniManager # AnimationManager node reference
var AniPlayer # StudyingBuddyAniPlayer node reference
var MenuUpButton # MenuUpButton node reference
var CloseButton # Button to quit the app
var ConfirmationScreen # Quit confirmation page


# Called when the node enters the scene tree for the first time.
func _ready():
	_hideBuddyExceptMug()
	$MenuUpButton.hide()
	Phone = get_node("Phone")
	TimeManager = get_node("TimeManager")
	MenuUpButton = get_node("MenuUpButton")
	CloseButton = get_node("CloseButton")
	ConfirmationScreen = get_node("Quit Confirmation Screen")
	
	get_node("PenOnDesk").hide()
	get_node("PhoneOnDesk").show()
	
	get_node("Pot/Pot Plant AniPlayer").play("Swing")
	
	await get_tree().create_timer(1.25).timeout # delay phone open animation by 1.25 seconds when app opens
	
	# Make menu button visible and pull up phone with settings screen visible
	$MenuUpButton.show()
	_on_menu_up_button_pressed()
	_on_settings_button_pressed()
	
	AniManager = $AnimationManager
	AniPlayer = get_node("StudyingBuddySkeleton/StudyingBuddyAniPlayer")

# _process(delta) method unused for this script
func _process(delta):
	pass

func _hideBuddyExceptMug():
	get_node("StudyingBuddy/ArmR").hide()
	get_node("StudyingBuddy/Tail").hide()
	get_node("StudyingBuddy/Torso").hide()
	get_node("StudyingBuddy/Desk CoverUp").hide()
	get_node("StudyingBuddy/Head").hide()
	get_node("StudyingBuddy/Nose").hide()
	get_node("StudyingBuddy/Closed Eye").hide()
	get_node("StudyingBuddy/PhoneOnHand").hide()
	get_node("StudyingBuddy/Pen").hide()
	get_node("StudyingBuddy/ArmL").hide()
	get_node("StudyingBuddy/Mug").show()


# Button press handlers below \/

# this code runs when MenuUpButton is pressed (phone button)
func _on_menu_up_button_pressed():
	Phone.up()
	MenuUpButton.hide()
	Phone.appScreenVisible()

# this code runs when MenuBackButton is pressed (close phone button)
func _on_menu_back_button_pressed():
	Phone.down()
	MenuUpButton.show()

# this code runs when MusicButton is pressed from AppScreen
func _on_music_button_pressed():
	Phone.musicScreenVisible()

# this code runs when SettingsButton is pressed from AppScreen
func _on_settings_button_pressed():
	# shows the appropraite settings screen if session is running or not
	if ((TimeManager) != null && TimeManager.getSessionRunning()):
		Phone.midScreenVisible()
	else:
		Phone.settingsScreenVisible()

# runs when mid-session settings screen back button is pressed
func _on_settings_back_button_2_pressed():
	Phone.appScreenVisible()

# this code runs when music screen back button is pressed
func _on_music_back_button_pressed():
	Phone.appScreenVisible()

# this code runs when the session start button is pressed in SettingsScreen
func _on_start_button_pressed():
	_on_menu_back_button_pressed() # put phone down

# this kicks the user off the mid-session-settings screen if they end the session
func _on_end_session_pressed():
	Phone.settingsScreenVisible()

# this code runs when the back button is pressed on the clock screen
func _on_clock_back_button_pressed():
	Phone.appScreenVisible()

# this code runs when the ClockButton is pressed from the AppScreen
func _on_clock_button_pressed():
	Phone.clockScreenVisible()

# quits the app when the close button is pressed
func _on_close_button_pressed():
	Phone.down()
	ConfirmationScreen.show()
	CloseButton.hide()

func _on_quit_button_pressed():
	get_tree().quit() 

func _on_cancel_button_pressed():
	ConfirmationScreen.hide() 
	CloseButton.show()

# resets to the beginning-of-session settings screen if user restarts after
# a session is completed
func _on_restart_pressed():
	get_node("Phone/MenuBackButton").show()
	Phone.settingsScreenVisible()
	TimeManager.resetClock()

# Queue up the next appropriate animation whenever "Idle" animation is running.
# This function checks the boolean "Studying" during the begining of Idle Animation.
# ^ Results in a >5 second delay on animations from the actual state change.
func _on_studying_buddy_ani_player_animation_started(anim_name):
	# If the animation that started now is "Idle", queue the next animation
	print(TimeManager.getSessionRunning())
	if (TimeManager.getSessionRunning() == true):
		if anim_name == "Idle":
			print("Idle Now, queuing:")
			var animation:String = AniManager._getAnimation()
			print(animation)
			AniPlayer.queue(animation)
		
		# If the animation started now is not "Idle", queue "Idle"
		else:
			AniPlayer.queue("Idle")
			print("Queuing Idle")
	else:
		print("No Session Running")

func _on_close_app_button_pressed():
	_on_close_button_pressed()
	get_node("Phone/MenuBackButton").show()
