extends Node2D

onready var level = $levels
onready var ui = $CanvasLayer/ui
onready var player = $Player

# Move speed
export var move_speed = 200

# Next level
export var next_level:String

func _ready():
	player.status = global.status
	player.transform.origin = player.status["transform"]

# Moving levels and updating UI
func _process(delta):
	level.translate(Vector2(-move_speed * delta, 0))
	
	player.status["score"] += move_speed * delta / 100
	
	ui.status = player.status
	
	# When player dies
	if player.status["hp"] <= 0:
		# Call UI fail function to handle it
		ui.fail()

# Passing damaged to player
func damaged(damage:int):
	player.damaged(damage)

# Passing score to player
func score(score:int):
	player.status["score"] += score

# Called when finish line passes last boundary
func finish():
	# Shows score etc and wait
	global.status = player.status
	
	# Goto next level after things receed.
	global.goto_scene(next_level)

func _on_Area2D_body_entered(body):
	if body.collision_layer == 1:
		damaged(1000)
