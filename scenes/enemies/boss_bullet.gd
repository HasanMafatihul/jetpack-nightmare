extends Area2D

# Bullet damage. Adjustable
export var damage = 10

# Bullet's speed
var speed = 15

export var texture_rect = [
	
]

var hit = 0

# Bullet movement
func _physics_process(delta):
	transform.origin.x -= speed

# Enemy hit something
func _on_enemy_body_entered(body):
	var layer = body.collision_layer
	match layer:
		# Player
		1:
			body.damaged(damage)
			queue_free()
		# Last Boundary
		8:
			queue_free()
	
