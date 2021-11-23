extends Node2D

# Setup
func _ready():
	global.status = {
		"hp": 100,
		"score": 0
	}
	
	global.goto_scene("res://scenes/levels/level-1.tscn")
