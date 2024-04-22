extends Sprite2D


var TimeManager

# Called when the node enters the scene tree for the first time.
func _ready():
	TimeManager = get_parent().get_parent().get_node("TimeManager")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible):
		updateIntervalTimeReadout()

func setIntervalTimerLabel(onBreak):
	if (onBreak):
		get_node("IntervalTimeLabel").set_text("Break time remaining:")
	else:
		get_node("IntervalTimeLabel").set_text("Time until break:")

func updateIntervalTimeReadout():
	var minutes = int(TimeManager.get_interval_time_remaining() / 60)
	var seconds = int(TimeManager.get_interval_time_remaining() - minutes * 60)
	get_node("IntervalTimeLabel").get_node("IntervalTimeReadout").set_text(str(minutes) + ":" + "%02d" % seconds)