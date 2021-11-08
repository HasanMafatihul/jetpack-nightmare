extends Area2D

export var damage = 10
export var move = 0

func _physics_process(delta):
	translate(Vector2(-move * delta, 0))

func _on_enemy_body_entered(body):
	var layer = body.collision_layer
	match layer:
		4:
			queue_free()
			body.queue_free()
		1:
			body.damaged(damage)
			queue_free()
		8:
			queue_free()
			get_node("/root/main").damaged()
	
