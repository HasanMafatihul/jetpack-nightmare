extends Control

# Player's status
var status = {
	"hp": 100
}

func _process(delta):
	# Updating UI
	$hp/hpbar.value = status["hp"]
	$coins.text = "Coins = " + str(global.save_data["coins"])
	
	# Pausing
	if Input.is_action_just_pressed("pause") && status["hp"] >= 0:
			get_tree().paused = true
			$pause.visible = true

# Resume button pressed
func _on_resume_pressed():
	get_tree().paused = false
	$pause.visible = false

# Exit button pressed
func _on_exit_pressed():
	get_tree().paused = false
	global.goto_scene("res://scenes/screens/main_menu.tscn")

# On fail (Called from main)
func fail():
	# Pause the game
	get_tree().paused = true
	
	# Play animation to show the fail node/screen
	$fail/AnimationPlayer.play("show")

# Fail node's exit button pressed
func _on_exit_fail_pressed():
	get_tree().paused = false
	global.goto_scene("res://scenes/screens/main_menu.tscn")
