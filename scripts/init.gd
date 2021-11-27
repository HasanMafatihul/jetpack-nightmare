extends Node2D

# Setup
func _ready():
	global.status = {
		"hp": 100,
		"score": 0,
		"transform": Vector2(104, 142),
		"damage": global.weapon["damage"],
		"cd": global.weapon["cd"],
		"text": global.weapon["text"]
	}
	
	global.goto_scene("res://scenes/levels/level-1.tscn")
