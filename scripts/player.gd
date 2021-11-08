extends KinematicBody2D

# Instance
var bullet = preload("res://scenes/bullet_default.tscn")

# Constant
const speed_y = 500
const speed_h = 500
var velocity

# Player status
var status = {
	"hp": 100,
	"coin": 0
}

# Input
func get_input():
	var movement = Vector2()
	if Input.is_action_pressed("move_up"):
		movement.y -= speed_y
	if Input.is_action_pressed("move_down"):
		movement.y += speed_y
	if Input.is_action_pressed("move_left"):
		movement.x -= speed_h
	if Input.is_action_pressed("move_right"):
		movement.x += speed_h
	return movement

func _physics_process(delta):
	velocity = get_input()
	move_and_collide(velocity * delta)

func _process(delta):
	
	# Shooting
	if Input.is_action_just_pressed("shoot"):
		var inst = bullet.instance()
		inst.transform = transform
		get_parent().add_child(inst)
		print("Shoot!")

func damaged(damage: int):
	status["hp"] -= damage
	print("HP = ", status["hp"])
