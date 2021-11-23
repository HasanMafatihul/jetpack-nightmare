extends Node

onready var ost = $ost
var turned = false
var volume = 100

var songDict = {
	"MainLevel0": "res://assets/song1.wav"
}

var soundDict = {
	"shoot" : "player/shoot",
}

func _process(_delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume/100))

func playSong(song: String):
	if turned:
		ost.stream.resource_path = songDict[song]
		ost.play()

func playSound(sound:String):
	get_node(soundDict[sound]).play()

func stopAll():
	ost.stop()
	for i in soundDict.keys():
		get_node(soundDict[i]).stop()