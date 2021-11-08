extends Area2D

func _on_coin_body_entered(body):
	if body.collision_layer == 1:
		global.coins += 1
		queue_free()
