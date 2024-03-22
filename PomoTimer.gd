extends Node

var time = 0.0
var running = false
var debug = 0

signal transmit_time(transmittedTime)


# Called when the node enters the scene tree for the first time.
func _ready():
	var mainScene = get_parent().get_parent()
	mainScene.start_timer.connect(on_start_timer)
	
	var timeManager = get_parent()
	timeManager.get_time.connect(on_get_time)
	timeManager.reset_timer.connect(on_reset_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if running:
		time += delta
	
	if debug == 60:
		debug = 0
		print(str(time) + "\n")
	else:
		debug += 1

func isRunning():
	return running

func toggleRunning():
	running = !running


func on_reset_timer():
	time = 0.0

func on_start_timer():
	if !running:
		toggleRunning()

func on_get_time():
	transmit_time.emit(time)
