extends Area2D

var random = RandomNumberGenerator.new()

# Enemy damage. Adjustable
export var damage = 10

# Score by killing
export var score = 5

# Enemy custom speed. Adjustable
export var move = 0

export var texture_rect = [
	
]

# Initiate
func _ready():
	# Change texture to random
	random.randomize()
	var rng = random.randi_range(0, texture_rect.size() - 1)
	print(rng)
	$icon.set_texture(load(texture_rect[rng]))

# Independent enemy movement
func _physics_process(delta):
	translate(Vector2(-move * delta, 0))

# Enemy hit something
func _on_enemy_body_entered(body):
	var layer = body.collision_layer
	match layer:
		# Bullet
		4:
			queue_free()
			body.queue_free()
			audio.playSound("enemy_die")
			get_node("/root/main").score(score)
		# Player
		1:
			body.damaged(damage)
			queue_free()
		# Last Boundary
		8:
			queue_free()
			print("Last bound")
			get_node("/root/main").damaged(damage)
	
