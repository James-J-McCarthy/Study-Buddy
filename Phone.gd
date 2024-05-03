extends Sprite2D
# this script is here to control visibility 
# for the various phone screens
# also has phone up and phone down 
var appscreen
var musicscreen
var settingsscreen
var midsettingsscreen
var clockscreen
var endScreen
var animationPlayer
var TimeManager

# Called when the node enters the scene tree for the first time.
func _ready():
	musicscreen = get_node("MusicScreen")
	settingsscreen = get_node("SettingsScreen")
	appscreen = get_node("AppScreen")
	clockscreen = get_node("ClockScreen")
	midsettingsscreen = get_node("MidSessionSettings")
	endScreen = get_node("SessionEndScreen")
	animationPlayer = get_node("../PhoneMover")
	TimeManager = get_parent().get_node("TimeManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func up():
	animationPlayer.play("PhoneUp")

func down():
	animationPlayer.play("PhoneDown")


func appScreenVisible():
	appscreen.show()
	midsettingsscreen.hide()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.hide()
	endScreen.hide()
	
	# code below prevents the user from trying to access the clock screen
	# without starting a session
	if (!TimeManager.getSessionRunning()): 
		settingsScreenVisible()

func musicScreenVisible():
	musicscreen.show()
	midsettingsscreen.hide()
	clockscreen.hide()
	appscreen.hide()
	settingsscreen.hide()
	endScreen.hide()

func midScreenVisible():
	appscreen.hide()
	midsettingsscreen.show()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.hide()
	endScreen.hide()
	
func clockScreenVisible():
	appscreen.hide()
	midsettingsscreen.hide()
	clockscreen.show()
	musicscreen.hide()
	settingsscreen.hide()
	endScreen.hide()

func settingsScreenVisible():
	appscreen.hide()
	midsettingsscreen.hide()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.show()
	endScreen.hide()

func endScreenVisible():
	appscreen.hide()
	midsettingsscreen.hide()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.hide()
	endScreen.show()
