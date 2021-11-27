extends Node2D

onready var level = $levels
onready var ui = $CanvasLayer/ui
onready var player = $Player
var enemy = preload("res://scenes/enemies/enemy_generic.tscn")
var rng = RandomNumberGenerator.new()

# Next level
export var next_level:String

func _ready():
	player.status = global.status
	player.transform.origin = player.status["transform"]
	$CanvasLayer/BossHealth.max_value = $boss_boss/boss.hp

# Moving levels and updating UI
func _process(delta):
	ui.status = player.status
	
	# When player dies
	if player.status["hp"] <= 0:
		# Call UI fail function to handle it
		ui.fail()
		
	$CanvasLayer/BossHealth.value = $boss_boss/boss.hp



# Passing damaged to player
func damaged(damage:int):
	player.damaged(damage)

# Passing score to player
func score(score:int):
	player.status["score"] += score

# Called when boss died
func finish():
	# Shows score etc and wait
	global.status = player.status
	
	# Goto next level after things receed.
	global.goto_scene(next_level)

# Boss' summon enemy
func _on_boss_summon_enemy():
	rng.randomize()
	var inst = enemy.instance()
	inst.transform.origin = Vector2(1085 + rng.randf_range(0, 50), rng.randf_range(0, 640))
	print("summon enemy")
	inst.speed = 2
	add_child(inst)
