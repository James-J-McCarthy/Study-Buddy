extends Node

var studyLimit = 10.0
var breakLimit = 10.0
var studying = true
var time

signal get_time
signal reset_timer


# Called when the node enters the scene tree for the first time.
func _ready():
	var pomoTimer = get_node("PomoTimer")
	pomoTimer.transmit_time.connect(_on_transmit_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateStudyingStatus()

func getStudying():
	return studying

func updateStudyingStatus():
	get_time.emit()
	
	if studying:
		if studyLimit < time:
			studying = false
			print(str(studying) + "\n")
			reset_timer.emit()
	else:
		if breakLimit < time:
			studying = true
			print(str(studying) + "\n")
			reset_timer.emit()


func _on_transmit_time(transmittedTime):
	time = transmittedTime
