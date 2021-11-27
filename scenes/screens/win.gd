extends Control

func _ready():
	var score = round(global.status["score"])
	$score.text = "Score = " + str(score)
	if score > global.save_data["high_score"]:
		global.save_data["high_score"] = score
	
