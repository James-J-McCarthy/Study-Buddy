extends Line2D

signal switch_mode;


func _increase():
	points[1].x += 10;
	
func _switch_mode():
	return points[1].x == 350;
	
func _on_timer_timeout():
	_increase();
	
	if _switch_mode():
		emit_signal("switch_mode");
		$Timer.stop();
