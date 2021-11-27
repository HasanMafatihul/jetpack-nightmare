extends Control

# Player's status
var status = {
	"hp": 100
}

onready var main = get_tree()

func _process(delta):
	# Updating UI
	$hp/hpbar.value = status["hp"]
	$coins.text = "Coins = " + str(global.save_data["coins"])
	$score.text = "Score = " + str(round(status["score"]))
	
	# Pausing
	if Input.is_action_just_pressed("pause") && status["hp"] >= 0:
			$pause.visible = true
			main.paused = true

# Resume button pressed
func _on_resume_pressed():
	main.paused = false
	$pause.visible = false

# Exit button pressed
func _on_exit_pressed():
	main.paused = false
	global.goto_scene("res://scenes/screens/main_menu.tscn")

# On fail (Called from main)
func fail():
	# Pause the game
	main.paused = true
	
	# Play animation to show the fail node/screen
	$fail/AnimationPlayer.play("show")
	$fail.visible = true

# Fail node's exit button pressed
func _on_exit_fail_pressed():
	main.paused = false
	global.goto_scene("res://scenes/screens/main_menu.tscn")
