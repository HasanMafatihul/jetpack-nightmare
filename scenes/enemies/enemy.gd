extends Area2D

var random = RandomNumberGenerator.new()

# Enemy damage. Adjustable
export var damage = 10

# Score by killing
var score = 5

# Enemy's HP
export var hp = 20

export var texture_rect = [
	
]

var hit = 0

# Initiate
func _ready():
	# Change texture to random
	random.randomize()
	var rng = random.randi_range(0, texture_rect.size() - 1)
	$icon.set_texture(load(texture_rect[rng]))
	
	# Setting enemy's score
	score = hp

# Independent enemy movement
func _physics_process(delta):
	if hit > 0:
		$icon.modulate = Color(1,0,0)
		hit -= delta
	else:
		$icon.modulate = Color(1,1,1)
	if hp <= 0:
		audio.playSound("enemy_die")
		get_node("/root/main").score(score)
		queue_free()

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
			queue_free()
		# Last Boundary
		8:
			queue_free()
			get_node("/root/main").damaged(damage)
	
