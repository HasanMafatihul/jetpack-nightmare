extends KinematicBody2D

# Bullet's speed
export var speed = 20

# Bullet's damage
var damage = 10

# Bullet's texture
var text = null

func _ready():
	$icon.texture = load(text)

# Bullet movement
func _physics_process(delta):
	
	var collision = move_and_collide(Vector2(speed, 0))
	
	if collision != null:
		queue_free()
