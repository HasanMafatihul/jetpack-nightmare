extends KinematicBody2D

export var speed = 10

func _physics_process(delta):
	var collision = move_and_collide(Vector2(speed, 0))
	if collision != null:
		queue_free()
		print("am free")
