# This node controls the elements visible on the ClockScreen app in the Phone
extends Sprite2D

var TimeManager # TimeManager node reference
var IntervalTimeLabel # Text labelling study interval timer readout as such for the user
var IntervalTimeReadout # Timer readout for remaining time on current study/break interval
var SessionTimeReadout # Timer readout for total remaining time in study session


# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager = get_parent().get_parent().get_node("TimeManager")
	IntervalTimeLabel = get_node("IntervalTimeLabel")
	IntervalTimeReadout = get_node("IntervalTimeReadout")
	SessionTimeReadout = get_node("SessionTimeLabel").get_node("SessionTimeReadout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible):
		updateIntervalTimeReadout()
		updateSessionTimeReadout()


func setIntervalTimerLabel(studying):
	if (studying):
		get_node("IntervalTimeLabel").set_text("Time until break:")
	else:
		get_node("IntervalTimeLabel").set_text("Break time remaining:")

# Formats and refreshes current study/break period interval timer readout
func updateIntervalTimeReadout():
	var minutes = int(TimeManager.get_interval_time_remaining() / 60)
	var seconds = int(TimeManager.get_interval_time_remaining() - minutes * 60)
	
	IntervalTimeReadout.set_text(str(minutes) + ":" + "%02d" % seconds)

# Formats and refreshes current total study session timer readout
func updateSessionTimeReadout():
	var hours = int((TimeManager.get_total_time_remaining() / 60) / 60)
	var minutes = int(TimeManager.get_total_time_remaining() / 60 - hours * 60)
	var seconds = int(TimeManager.get_total_time_remaining() - minutes * 60 - hours * 3600)
	
	SessionTimeReadout.set_text(str(hours) + ":" + "%02d" % minutes + ":" + "%02d" % seconds)
