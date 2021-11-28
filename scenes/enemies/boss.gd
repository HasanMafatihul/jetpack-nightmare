extends Area2D

# Enemy damage. Adjustable
export var damage = 1000

var rng = RandomNumberGenerator.new()

# Movement counter
var counter = 0

# Shooting var
var cd = 0.0
var bullet = preload("res://scenes/enemies/boss_bullet.tscn")

# Score by killing
var score

# Boss' HP
export var hp = 1000

export var texture_rect = [
	
]

var hit = 0

# Initiate
func _ready():
	# Setting enemy's score
	score = hp

func _physics_process(delta):
	rng.randomize()
	# Boss' movement
	if counter <= 0 and $AnimationPlayer.current_animation == "":
		# Randomize action
		var r
		if $icon.animation == "glitch_fast":
			for i in range(rng.randi_range(1,2)):
				emit_signal("summon_enemy")
			r = rng.randi_range(0,9)
		else:
			r = rng.randi_range(0,10)
		
		if $icon.animation == "glitch":
			for i in range(rng.randi_range(2,3)):
				emit_signal("summon_enemy")
		
		$icon.playing = false
		$icon.frame = 0
		$icon.animation = "stop"
		
		if r < 7:
			$AnimationPlayer.play("move")
			counter = rng.randi_range(2,4)
		elif r < 9:
			$icon.play("glitch")
			counter = rng.randf_range(1,4)
			audio.playSound("boss_boss")
		elif r <= 10:
			$icon.play("glitch_fast")
			counter = 1
			audio.playSound("boss_boss")
	
	# State machine counter
	if $icon.playing:
		counter -= delta
	elif $AnimationPlayer.current_animation == "":
		counter -= 1
		$AnimationPlayer.play("move")

	# Boss' hit color
	if hit > 0:
		$icon.modulate = Color(1,0,0)
		hit -= delta
	else:
		$icon.modulate = Color(1,1,1)
	
	# Boss' death
	if hp <= 0:
		get_node("/root/main").score(score)
		get_node("/root/main").finish()
	
	# Boss' attack
	cd -= delta
	if $AnimationPlayer.current_animation == "move":
		if cd <= 0:
			cd = rng.randf_range(1,2)
			shoot()

# Enemy hit something
func _on_enemy_body_entered(body):
	var layer = body.collision_layer
	match layer:
		# Bullet
		4:
			hp -= body.damage
			hit = 0.2
			body.queue_free()
		# Player
		1:
			body.damaged(damage)
		# Last Boundary
		8:
			queue_free()
			get_node("/root/main").damaged(damage)

func shoot():
	var inst = bullet.instance()
	var parent = get_parent().transform.origin
	inst.transform.origin = Vector2(parent.x, parent.y + transform.origin.y)
	inst.damage = 10
	print("shoot")
	get_parent().get_parent().add_child(inst)

signal summon_enemy()
