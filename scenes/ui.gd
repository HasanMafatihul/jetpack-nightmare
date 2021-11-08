extends Control

# Player's status
var status = {
	"hp": 100
}

func _process(delta):
	# Updating UI
	$hp.text = "HP = " + str(status["hp"])
	
	# Pausing
	if Input.is_action_just_pressed("pause"):
			get_tree().paused = !get_tree().paused
			print("paused")
