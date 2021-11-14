extends Node2D

onready var level = $levels
onready var ui = $CanvasLayer/ui
onready var player = $Player

# Move speed
export var move_speed = 200

# Moving levels and updating UI
func _process(delta):
	level.translate(Vector2(-move_speed * delta, 0))
	ui.status = player.status

# Passing damaged to player
func damaged(damage:int):
	player.damaged(damage)

# Called when finish line passes last boundary
func finish():
	# Shows score etc and wait
	
	# Goto next level after things receed.
	global.goto_scene("res://scenes/levels/level-1.tscn")
	pass
