extends Node

@onready var study_music = $StudyMusic
@onready var break_music = $BreakMusic
@onready var sfx_nose_honk = $SFXNoseHonk

@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@onready var fadePlayer = AudioStreamPlayer.new()
var fadingStudyMusic = false
var fadingBreakMusic = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(fadePlayer)
	break_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#VERSION 1 - optimal version but having issues :(
	#if (break_music.playing == true):
		#if fadingBreakMusic:
			#break_music.volume_db -= 15*delta
			#fadePlayer.volume_db += 15*delta
			#
			#if (fadePlayer.volume_db >= 0):
				##break_music.volume_db = 0
				##break_music.volume_db = -60
				#
				#fadePlayer.stream = break_music.stream
				##break_music.play(fadePlayer.get_playback_position())
#
				#fadePlayer.stop()
				#fadingBreakMusic = false	
				
	#VERSION 2
	if (break_music.playing == true):
		if fadingBreakMusic:
			break_music.volume_db -= 10*delta
			#fadePlayer.volume_db += 10*delta
			
			if (break_music.volume_db <= -30):
				if(study_music.playing != true):
					
					study_music.play()
					study_music.volume_db = -10
					break_music.volume_db = -60
				#if (study_music.volume_db <= 10):
					#print('hi')
					#study_music.volume_db += 10*delta				
				
				fadePlayer.stream = break_music.stream
				#break_music.play(fadePlayer.get_playback_position())

				break_music.stop()
				#fadePlayer.stop()
				fadingBreakMusic = false	
				
	if (study_music.playing == true):
		if fadingStudyMusic:
			study_music.volume_db -= 30*delta
			fadePlayer.volume_db += 30*delta
			
			if (fadePlayer.volume_db >= 0):
				study_music.volume_db = 0
				fadePlayer.volume_db = 60
				if(study_music.playing != true):
					
					break_music.play()
				
				study_music.stream = fadePlayer.stream
				study_music.play(fadePlayer.get_playback_position())

				fadePlayer.stop()
				fadingStudyMusic = false	

# volume only refers to music volume currently
func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Music_BUS_ID, value < 0.05)

# add in if we add a sfx volume slider (change the function name)
#func _on_volume_slider_value_changed(value):
	#AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	#AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)

func startStudyMusic():
	#fadePlayer.stream = study_music
	#fadePlayer.volume_db = -60
	#fadePlayer.play()
	
	fadingBreakMusic = true
	#break_music.stop()
	#study_music.play()
	
func startBreakMusic():
	fadePlayer.stream = study_music
	fadePlayer.volume_db = -60
	fadePlayer.play()
	
	fadingStudyMusic = true
	#study_music.stop()
	#break_music.play()
	
