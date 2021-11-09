extends Node2D

onready var level = $levels
onready var ui = $CanvasLayer/ui
onready var player = $Player
var move_speed = 200

export var world_health = 10

func _process(delta):
	level.translate(Vector2(-move_speed * delta, 0))
	ui.status = player.status

func damaged(damage:int):
	player.damaged(damage)
