extends Control

func _ready():
	$VBoxContainer/master.value = audio.volume_master
	$VBoxContainer/sound.value = audio.volume_sfx

func _process(delta):
	audio.volume_master = $VBoxContainer/master.value
	audio.volume_sfx = $VBoxContainer/sound.value

func _on_reset_pressed():
	global.save_data = {
		"coins": 0,
		"high_score": 0,
		"bought_weapons": ["Default"]
	}
	global.save_game()
