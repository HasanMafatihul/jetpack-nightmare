extends Node

onready var ost = $ost
var turned = true
var volume_master = 100
var volume_sfx = 100

var songDict = {
	"ost_default": "res://audio/ost/menu-stage_mungkin.mp3",
	"ost_boss": "res://audio/ost/audioo/track boss maybe.mp3",
}

var soundDict = {
	"shoot" : "player/shoot",
	"enemy_die" : "enemy/die",
	"player_die" : "player/die",
	"boss_boss" : "boss/boss",
	"coin_pop" : "coin/pop",
}

# Setting the volume every process
func _process(_delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume_master/100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear2db(volume_sfx/100))

# Play song using ost audiostream
func playSong(song: String):
	if turned:
		ost.stream.resource_path = songDict[song]
		ost.play()

# Play sound using respective audiostream
func playSound(sound:String):
	get_node(soundDict[sound]).play()

func stopAll():
	ost.stop()
	for i in soundDict.keys():
		get_node(soundDict[i]).stop()
