extends Node
# This node has a timer which is sets to count down 
# from specified lengths to determine when to update other nodes
# Very first call to set study time is in MaineScene.gd script
# By defualt, study_time and break_time are set to their slider's min values
# which can be found by going to phone > settings screen > Slider in question

# var declarations:
# 
var study_time # time of "study session" measured in seconds 
var break_time # ^ for breaks
var cyclesTotal = 4 # < prob don't initialize this here # total number of study/break cycles user wants
var cycle = 1 # current cycles count
var studying = true

# Called when the node enters the scene tree for the first time.

func _ready(): 
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(cycle <= cyclesTotal):
		var clockHand = get_node_or_null("../clockHand");
		if (clockHand == null):
			print("clockhand == null error!");
			pass
		else:
			var currentDegree = get_node("../clockHand").rotation;
			var degreeChange = (_delta / break_time + study_time)/360;
			currentDegree += degreeChange;
			if (currentDegree >= 360): 
				currentDegree -= 360;
			get_node("../clockHand").rotation = currentDegree;

# helper function that starts pomo timer given a period length
func start_period(duration):
	$PomoTimer.start(duration)

# begins a study period on Pomo-Timer passing in study_time
# Timer is set to "One-Shot" meaning it doesn't repeat after finishing
func start_study_timer():
	#print("start studying for: ", study_time, "seconds")
	start_period(study_time)
	studying = true

#begins a study period on Pomo-Timer using break_time
func start_break_timer():
	#print("start break")
	start_period(break_time)
	studying = false

func hit_pause():
	if($PomoTimer.is_paused):
		$PomoTimer.set_paused(false)
	else:
		$PomoTimer.set_paused(true)


# SIGNALS: 
func _on_session_time_slider_value_changed(value):
	study_time = value

func _on_break_time_slider_value_changed(value):
	break_time = value

# get's signal from pomo timer when it finishes or when time is reduced to < 0
# then restarts timer based on next period length
func _period_finished(): # I tested this funciton with a print to ensure it works
	updateCycleNumerator()
	if(cycle <= cyclesTotal):
		if(studying):
			#print("done studying!!")
			if(break_time > 0): # update our boolean before switching
				studying = false
			start_break_timer() # switch PomoClocks timing duration
		else:
			#print("done with break!!")
			if(study_time > 0): # update our boolean before switching
				studying = true
			start_study_timer() # switch PomoClocks timing duration
	else: 
		print("finished study period!!")

# This function creates the text that displays the cycle
# count. 
# It should be called before the first exacution of start
# period. 
func initializeClockLabelText():
	var cycleLabel = get_node("../CycleLabel")
	cycleLabel.text = str(cycle, "/", cyclesTotal)

# getters and setters below \/
func updateCycleNumerator():
	var cycleLabel = get_node("../CycleLabel")
	cycle += 1
	if(cycle <= cyclesTotal):
		cycleLabel.text = str(cycle, "/", cyclesTotal)
	
func getStudying():
	return studying

func set_break_time(new_duration):
	break_time = new_duration

func set_study_time(new_duration):
	study_time = new_duration
