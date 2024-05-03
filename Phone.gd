# This script node controls visibility for the various phone screens
# and also has phone up and phone down animation trigger methods
extends Sprite2D

var AppScreen # AppScreen node reference
var MusicScreen # MusicScreen node reference
var SettingsScreen # SettingsScreen node reference
var MidSettingsScreen # MidSessionSettings node reference
var ClockScreen # ClockScreen node reference
var EndScreen # EndScreen node reference
var AniPlayer # StudyingBuddyAniPlayer node reference
var TimeManager # TimeManager node reference
var PhoneUp = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicScreen = get_node("MusicScreen")
	SettingsScreen = get_node("SettingsScreen")
	AppScreen = get_node("AppScreen")
	ClockScreen = get_node("ClockScreen")
	MidSettingsScreen = get_node("MidSessionSettings")
	EndScreen = get_node("SessionEndScreen")
	AniPlayer = get_node("../PhoneMover")
	TimeManager = get_parent().get_node("TimeManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Phone up/down animations are triggered by the two methods below \/
func up():
	if (!PhoneUp):
		AniPlayer.play("PhoneUp")
		PhoneUp = true;
	else:
		print("phone already up")

func down():
	if (PhoneUp):
		AniPlayer.play("PhoneDown")
		PhoneUp = false;


# Methods to show each app's screen on the Phone below \/
func appScreenVisible():
	_hideAll()
	AppScreen.show()
	
	# code below prevents the user from trying to access the clock screen
	# without starting a session
	if (!TimeManager.getSessionRunning()): 
		settingsScreenVisible()

func musicScreenVisible():
	_hideAll()
	MusicScreen.show()

func midScreenVisible():
	_hideAll()
	MidSettingsScreen.show()

func clockScreenVisible():
	_hideAll()
	ClockScreen.show()

func settingsScreenVisible():
	_hideAll()
	SettingsScreen.show()

func endScreenVisible():
	_hideAll()
	get_node("MenuBackButton").hide()
	EndScreen.show()

# This method is purely for consolidating repeating code in the above visibility functions
func _hideAll():
	AppScreen.hide()
	MidSettingsScreen.hide()
	ClockScreen.hide()
	MusicScreen.hide()
	SettingsScreen.hide()
	EndScreen.hide()
