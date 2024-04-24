extends Node

@onready var study_music = $StudyMusic
@onready var break_music = $BreakMusic
@onready var sfx_nose_honk = $SFXNoseHonk

@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready():
	break_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#I don't think I correctly figured out how to get study buddy's current studying status T_T
	# that or the process isn't flowing correctly (issues with the stop aand start - doesn't like changing audios??)
	
	var studying = get_parent().get_node("TimeManager").getStudying()
	#print(studying) #is this ever false?
	
	#program does not want to play a new audio after an audio has been stopped during _process?

	#if (studying == true):
		#if (break_music.playing == true):
			#break_music.stop()
		#study_music.play()
	#else:
		#if (study_music.playing == true):
			#study_music.stop()
		#break_music.play()

# volume only refers to music volume currently
func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Music_BUS_ID, value < 0.05)

# add in if we add a sfx volume slider (change the function name)
#func _on_volume_slider_value_changed(value):
	#AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	#AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
