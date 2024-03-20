extends Node

const MINUTE = 60.0
var time = 0.0
var timeLimit = 20 * MINUTE
var timerRunning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timerRunning && time <= timeLimit:
		time += delta

func getTime():
	return time

func isRunning():
	return timerRunning

func resetTime():
	time = 0.0

func toggleRunning():
	timerRunning = !timerRunning
