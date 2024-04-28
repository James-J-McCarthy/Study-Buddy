extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func _on_break_time_slider_value_changed(value):
	set_text(str(value)) 
