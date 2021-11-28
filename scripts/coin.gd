extends Area2D

# When touched player
func _on_coin_body_entered(body):
	if body.collision_layer == 1:
		audio.playSound("coin_pop")
		global.save_data["coins"] += 1
		queue_free()
