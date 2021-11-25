extends Area2D

var rng = RandomNumberGenerator.new()

# Obstacle damage. Adjustable
export var damage = 10

# Obstacle skins
var skins = [preload("res://visual/Obstacle/Obstacle 1.PNG"), preload("res://visual/Obstacle/Obstacle 2.PNG")]

func _ready():
	rng.randomize()
	$sprite.texture = skins[rng.randi_range(0,1)]
	rotate(rng.randf_range(0,360))

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
