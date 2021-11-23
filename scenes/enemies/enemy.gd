extends Area2D

# Enemy damage. Adjustable
export var damage = 10

# Score by killing
export var score = 5

# Enemy custom speed. Adjustable
export var move = 0

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
	
