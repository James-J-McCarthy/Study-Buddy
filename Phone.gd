extends Sprite2D
# this scrip is here to more easily control visibility 
# for the various phone screens
var appscreen
var musicscreen
var settingsscreen
var midsettingsscreen
var clockscreen

# Called when the node enters the scene tree for the first time.
func _ready():
	musicscreen = get_node("MusicScreen")
	settingsscreen = get_node("SettingsScreen")
	appscreen = get_node("AppScreen")
	clockscreen = get_node("ClockScreen")
	midsettingsscreen = get_node("MidSessionSettings")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func appScreenVis():
	appscreen.show()
	midsettingsscreen.hide()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.hide()
	

func musicScreenVis():
	musicscreen.show()
	midsettingsscreen.hide()
	clockscreen.hide()
	appscreen.hide()
	settingsscreen.hide()

func midScreenVis():
	appscreen.hide()
	midsettingsscreen.show()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.hide()
	
func clockScreenVis():
	appscreen.hide()
	midsettingsscreen.hide()
	clockscreen.show()
	musicscreen.hide()
	settingsscreen.hide()

func settingsScreenVis():
	appscreen.hide()
	midsettingsscreen.hide()
	clockscreen.hide()
	musicscreen.hide()
	settingsscreen.show()
