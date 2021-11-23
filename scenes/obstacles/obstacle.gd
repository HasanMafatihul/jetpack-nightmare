extends Area2D

# Obstacle damage. Adjustable
export var damage = 10

# Obstacle hit something


func _on_obstacle_body_entered(body):
	var layer = body.collision_layer
	match layer:
		# Bullet
		4:
			body.queue_free()
		# Player
		1:
			body.damaged(damage)
