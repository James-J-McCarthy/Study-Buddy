extends Node

@onready var study_music = $StudyMusic
@onready var break_music = $BreakMusic
@onready var sfx_nose_honk = $SFXNoseHonk
@onready var sfx_session_end = $SFXSessionEnd

@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

var fadingStudyMusic = false
var fadingBreakMusic = false
var userInputVolume

# Called when the node enters the scene tree for the first time.
func _ready():
	break_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if break_music.playing:
		if fadingBreakMusic:
			break_music.volume_db -= 10*delta
			if (break_music.volume_db <= -30):
				if(study_music.playing != true):
					study_music.play()
					study_music.volume_db = -10
					break_music.volume_db = -60
				if (study_music.volume_db <= 10): #less than or equal to correct volume		#create helper method for 
					print('hi')
					study_music.volume_db += 10*delta

				break_music.stop()
				fadingBreakMusic = false	
		#else set to correct volume
	if study_music.playing:
		if fadingStudyMusic:
			study_music.volume_db -= 10*delta
			if (study_music.volume_db <= -30):
				if(break_music.playing != true):
					break_music.play()
					break_music.volume_db = -10
					study_music.volume_db = -60
					
				if (study_music.volume_db <= 20):
					print('hi')
					study_music.volume_db += 5
	

				study_music.stop()
				fadingStudyMusic = false

# volume only refers to music volume currently
func _on_volume_slider_value_changed(value):
	userInputVolume = value
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(userInputVolume))
	AudioServer.set_bus_mute(Music_BUS_ID, userInputVolume < 0.05)

# sfx volume slider -- currently only for the end of session chime
func _on_sfx_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)

func startStudyMusic():
	fadingBreakMusic = true
	#break_music.stop()
	#study_music.play()
	
func startBreakMusic():
	fadingStudyMusic = true
	#study_music.stop()
	#break_music.play()

func sessionEndMusic():
	sfx_session_end.play()
	fadingStudyMusic = true
	#study_music.stop()
	#break_music.play()



