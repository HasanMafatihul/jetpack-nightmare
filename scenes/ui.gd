extends Control

var status = {
	"hp": 100
}

func _process(delta):
	$hp.text = "HP = " + str(status["hp"])
