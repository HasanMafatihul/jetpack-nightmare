extends KinematicBody2D

# Instance
var bullet = preload("res://scenes/bullet_default.tscn")

# Constant
const speed_y = 500
const speed_h = 500

# Variables
var velocity
var cd_timer = 0

# Player status
var status = {
	"hp": 100,
	"coin": 0,
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

# Move per physic process (see godot documentation)
func _physics_process(delta):
	velocity = get_input()
	move_and_collide(velocity * delta)

func _process(delta):
	
	# Updating status transform
	status["transform"] = transform.origin
	
	# Cooldown timer
	if cd_timer > 0:
		cd_timer -= delta
	
	# Shooting
	if Input.is_action_pressed("shoot") and cd_timer <= 0:
		var inst = bullet.instance()
		inst.transform = transform
		inst.damage = status["damage"]
		get_parent().add_child(inst)
		audio.playSound("shoot")
		cd_timer = status["cd"]


# Getting damaged
func damaged(damage: int):
	status["hp"] -= damage
