# This is 2D because SFX and stuff will want to be played at certain positions.

# I think the only way to really do this is to make a new AudioStreamPlayer(2D) for every sound... yikes.

# To play a sound, you can simply do AudioManager.play_(sfx/music/ambience)("IdOfSound")

# If the audio exists it returns true, if it doesn't it returns false

extends Node2D

onready var swish_sfx = $Swish
onready var placeholder_music = $PlaceHolderMusic
onready var rocken_music = $RockenMusic
onready var bird_chirps_amb = $BirdChirps
onready var warning = $Warning
onready var cymbal_crash = $CymbalCrash
onready var heartbeat = $Heartbeat

onready var sfx = {
	"swish": swish_sfx,
	"warning": warning,
	"cymbal": cymbal_crash,
	"beat": heartbeat
}

onready var music = {
	"placeholder": placeholder_music,
	"rocken": rocken_music
}

onready var ambience = {
	"bird_chirps": bird_chirps_amb
}

func play_sfx(id : String, pos : Vector2) -> bool:
	if sfx.has(id):
		sfx[id].position = pos
		sfx[id].play()
		return true
	else:
		return false

func play_music(id : String):
	if music.has(id):
		music[id].play()
		return true
	else:
		return false

func play_ambience(id : String, pos : Vector2):
	if ambience.has(id):
		ambience[id].position = pos
		ambience[id].play()
		return true
	else:
		return false
