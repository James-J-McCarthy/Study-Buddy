extends Node
# This node has a timer which is sets to count down 
# from specified lengths to determine when to update other nodes

# var declarations: 
var study_time = 10.0 # time is measured in seconds 
var break_time = 5.0 # time is measured in seconds 
var studying = true

# Called when the node enters the scene tree for the first time.
func _ready():
	start_study_timer()

# helper function that starts pomo timer given a period length
func start_period(duration):
	$PomoTimer.start(duration)

func start_study_timer():
	start_period(study_time)
	studying = true

func start_break_timer():
	start_period(break_time)
	studying = false

# get's signal from pomo timer when it finishes
func _period_finished():
	print("Timer Finished!!") # --> place command to change animations here !!!!!



# getters and setters below \/

func getStudying():
	return studying

func set_break_time(new_duration):
	break_time = new_duration

func set_study_time(new_duration):
	study_time = new_duration
