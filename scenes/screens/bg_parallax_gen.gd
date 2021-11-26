extends Node2D

export var max_x = 0
export var speed = 5

func _process(delta):
	translate(Vector2(-speed, 0))
	if transform.origin.x <= max_x:
		transform.origin.x -= max_x
