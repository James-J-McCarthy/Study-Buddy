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
var cycles_total # < prob don't initialize this here # total number of study/break cycles user wants
var cycle = 1 # current cycles count
var studying = true
var session_running = false
var paused = true
var phone
var PomoTimer

# Called when the node enters the scene tree for the first time.

func _ready(): 
	phone = get_node("../Phone")
	PomoTimer = $"PomoTimer"
	getPeriodValues() #initilize values

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	updateClockHand(_delta, true)

# this function moves the clock hand based on time past since the last 
# call of this function (delta)
# and a boolean. if dontReset is false, puts hand back to '12
func updateClockHand(_delta, dontReset):
	if (cycles_total != null && paused == false):
		if (cycle <= cycles_total):
			var clockHand = get_node_or_null("../clockHand")
			if (clockHand == null):
				print("clockhand == null error!")
				pass
			else:
				var currentRad = get_node("../clockHand").rotation
				var radsPerSecond = float((2*PI) / (break_time + study_time))
				var radChange = float(_delta*radsPerSecond)
				currentRad += radChange
				if (currentRad >= float((2*PI))): 
					currentRad = 0
					cycle+=1
				if(!dontReset):
					currentRad = 0
				get_node("../clockHand").rotation = currentRad

func getPeriodValues():
	study_time = get_node("../Phone/SettingsScreen/StudyTimeSlider").value * 60
	cycles_total = get_node("../Phone/SettingsScreen/CyclesSlider").value 
	break_time = get_node("../Phone/SettingsScreen/BreakTimeSlider").value * 60
	
# helper function that starts pomo timer given a period length
func start_period(duration):
	if(PomoTimer == null):
		PomoTimer = get_node("PomoTimer")
	PomoTimer.start(duration)

# begins a study period on Pomo-Timer passing in study_time
# Timer is set to "One-Shot" meaning it doesn't repeat after finishing
func start_study_timer():
	#print("start studying for: ", study_time, "seconds")
	start_period(study_time)
	updateCycleNumerator()
	studying = true
	var musicManager = get_node("../MusicManager")
	if(musicManager != null):
		musicManager.startStudyMusic()

#begins a study period on Pomo-Timer using break_time
func start_break_timer():
	#print("start break")
	start_period(break_time)
	studying = false
	var musicManager = get_node("../MusicManager")
	if(musicManager != null):
		musicManager.startBreakMusic()

# pause/unpause function
func hit_pause():
	paused = !paused
	if(paused):
		PomoTimer.set_paused(true)
	else:
		PomoTimer.set_paused(false)

# SIGNALS: 
func _on_session_time_slider_value_changed(value):
	study_time = value

func _on_break_time_slider_value_changed(value):
	break_time = value

# get's signal from pomo timer when it finishes or when time is reduced to < 0
# then restarts timer based on next period length
func _period_finished(): # I tested this funciton with a print to ensure it works
	if(studying):
		print("done studying!!")
		studying = false
		start_break_timer() # switch PomoClocks timing duration
	else:
		print("done with break!!")
		
		# ">" because by the time this runs the last time, cycle
		# will already be updated.
		if(cycle > cycles_total):
			#end of session logic triggered here:
			phone.up()
			phone.endScreenVis()
			print("finished study period!!")
			var musicManager = get_node("../MusicManager")
			if(musicManager != null):
				musicManager.sessionEndMusic()
		else:
			start_study_timer() # switch PomoClocks timing duration
			studying = true
		#cycle += 1
		updateCycleNumerator()
	phone.get_node("ClockScreen").setIntervalTimerLabel(studying)

	

# ends the current session running on the clock. 
func endSession():
	paused = false # this prevents a bug with the clock hand not resetting on session end
	resetClock()
	var musicManager = get_node("../MusicManager")
	if(musicManager != null):
		musicManager.sessionEndMusic()

func setBreakMarker():
	var angleInRad = study_time * (float((2*PI) / (break_time + study_time)))
	var bm = get_node("../breakMarker")
	bm.rotation = angleInRad


func startSession():
	getPeriodValues()
	initializeClockLabelText()
	start_study_timer()
	session_running = true
	paused = false
	setBreakMarker()

# resets clock but does not restart it
func resetClock():
	updateClockHand(0, false) # reset clock hand
	PomoTimer.stop() # stop timer
	set_cycle(1)
	initializeClockLabelText()
	session_running = false
	paused = true
	get_node("../Phone/MidSessionSettings/(un)Pause").resetText()

# This function creates the text that displays the cycle
# count. 
# It should be called before the first exacution of start
# period. 
func initializeClockLabelText():
	var cycleLabel = get_node("../CycleLabel")
	cycleLabel.text = str(cycle, "/", cycles_total)

# getters and setters below \/
func updateCycleNumerator():
	var cycleLabel = get_node("../CycleLabel")
	if(cycle <= cycles_total):
		cycleLabel.text = str(cycle, "/", cycles_total)

func getStudying():
	return studying

func set_break_time(new_duration):
	break_time = new_duration

func set_study_time(new_duration):
	study_time = new_duration

func set_cycles_total(new_cycles_total):
	cycles_total = new_cycles_total

func get_break_time():
	return break_time

func get_study_time():
	return study_time

func get_cycles_total():
	return cycles_total

func get_session_running():
	return session_running

func get_interval_time_remaining():
	return PomoTimer.get_time_left()

func get_total_time_remaining():
	if (studying):
		return PomoTimer.get_time_left() + break_time + (cycles_total - cycle) * (break_time + study_time)
	else:
		return PomoTimer.get_time_left() + (cycles_total - cycle) * (break_time + study_time)

func toggle_session_running():
	session_running = !session_running

func set_cycle(num):
	cycle = num

#Signals Below: 

# runs when settings start button is pressed
func _on_start_button_pressed():
	phone.get_node("SettingsScreen").getStudyTime()
	phone.get_node("SettingsScreen").getBreakTime()
	phone.get_node("SettingsScreen").getCyclesTotal()	
	startSession()


func _on_un_pause_pressed():
	hit_pause()

func _on_end_session_pressed():
	endSession()	
