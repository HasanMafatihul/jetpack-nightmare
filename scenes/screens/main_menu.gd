extends Control

func _ready():
	$score.text = "High Score : " + str(global.save_data["high_score"])
	audio.playSong("ost_default")


func _on_reset_data_pressed():
	var save_data = {
		"coins": 0,
		"high_score": 0,
		"bought_weapons": ["Default"]
	}
	global.save_game()
