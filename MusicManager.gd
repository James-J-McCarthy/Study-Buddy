# This node manages what sounds and music are playing at any given time
extends Node

@onready var studyMusic = $StudyMusic # StudyMusic asset reference
@onready var breakMusic = $BreakMusic # BreakMusic asset reference
@onready var SFXNoseHonk = $SFXNoseHonk # SFXNoseHonk asset reference
@onready var SFXSessionEnd = $SFXSessionEnd # SFXSessionEnd asset reference

@onready var Music_BUS_ID = AudioServer.get_bus_index("Music") 
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

var fadingStudyMusic = false
var fadingBreakMusic = false
var userInputVolume = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	breakMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# calls transitionMusic if a fade variable is true. Otherwise, it sets the current audio to the user's input volume.
func _process(delta):
		if fadingBreakMusic:
			transitionMusic(studyMusic, breakMusic, delta)
		else: # set to correct volume
			breakMusic.volume_db  = linear_to_db(userInputVolume)
		if fadingStudyMusic:
			transitionMusic(breakMusic, studyMusic, delta)
		else: # set to correct volume
			studyMusic.volume_db  = linear_to_db(userInputVolume)


# detects if the undesired audio is playing. If so, it decrements and begins playing the desired audio
# slowly incrementing until it matches the user's input volume.
func transitionMusic(transitionIn, transitionOut, delta):
	if transitionOut.playing:
			transitionOut.volume_db -= 10*delta
			if (transitionOut.volume_db <= -30):
				if(!transitionIn.playing):
					transitionIn.play()
					transitionIn.volume_db = -10
					transitionOut.volume_db = -60
				if (transitionIn.volume_db <= linear_to_db(userInputVolume)):
					transitionIn.volume_db += 5*delta
				transitionOut.stop()
				stopFading()


# reverts a current true fading variable back to false
func stopFading():
	fadingBreakMusic = false
	fadingStudyMusic = false


# changes the volume of the music (study and break) based on the user's input on the music volume slider
func _on_volume_slider_value_changed(value):
	userInputVolume = value
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(userInputVolume))
	AudioServer.set_bus_mute(Music_BUS_ID, userInputVolume < 0.05)


# changes the volume of the sound effects based on the user's input on the sfx volume slider (currently only for the end of session chime)
func _on_sfx_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)


func startStudyMusic():
	fadingBreakMusic = true


func startBreakMusic():
	fadingStudyMusic = true


# plays the end of session sound effect
func sessionEndMusic():
	SFXSessionEnd.play()
	fadingStudyMusic = true

