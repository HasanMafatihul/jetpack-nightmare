extends Area2D

# When passing last boundary
func _on_finish_body_entered(body):
	var tree = get_tree().root.get_node("main")
	if body.collision_layer == 8:
		tree.finish()
