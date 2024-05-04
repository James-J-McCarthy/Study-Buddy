# This node controls the progress bar on the clock readout app screen
extends Line2D

var allowIncrement = false
var incrementSize
var timeManager 
var pausePresses = 0
var timerBarStartPoint = 65
var timerBarEndPoint = 185

# every second, this method checks if the timer bar has reached the max. If not, it calls the increase function to lengthen the bar
func _on_timer_timeout():
	timeManager = get_node("../../../../TimeManager")
	if (timeManager != null):
		if (timeManager.getSessionRunning()):
			var totalSessionTime = timeManager.get_cycles_total() * (timeManager.get_break_time() + timeManager.get_study_time())
			incrementSize = (timerBarEndPoint - timerBarStartPoint) / totalSessionTime
			if (points[1].x >= timerBarEndPoint || (pausePresses%2 != 0)):
				allowIncrement = false
			else:
				allowIncrement = true
				increase()

# increments the timer bar by the incrementSize if it is below the max
func increase():
	if allowIncrement:
		if ((points[1].x + incrementSize) <= timerBarEndPoint):
			points[1].x += incrementSize


# when the session is ended by the user, the timer bar restarts visually and doesn't increase
func _on_end_session_pressed():
	allowIncrement = false
	points[1].x = timerBarStartPoint
	

# if the user pauses the timer, the timer bar doesn't increase
func _on_un_pause_pressed():
	pausePresses += 1
	

# when the session is restarted, the timer bar restarts visually and doesn't increase
func _on_restart_pressed():
	allowIncrement = false
	points[1].x = timerBarStartPoint
