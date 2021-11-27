extends Control

func _ready():
	$score.text = "High Score : " + str(global.save_data["high_score"])
