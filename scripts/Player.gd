extends KinematicBody2D

var movespeed = 500
var bulletSpeed = 1000
var bullet = preload("res://scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
		
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LMB"):
		fire()
	
func fire():
	var bulletInstance = bullet.instance()
	bulletInstance.position = get_global_position()
	bulletInstance.rotation_degrees = rotation_degrees * rand_range(0, 1)
	
	# do not collide with player :)
	bulletInstance.set_collision_mask_bit(0, false)
	bulletInstance.set_collision_mask_bit(1, true)
	bulletInstance.set_collision_layer_bit(0, false)
	
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bulletInstance) # queing function

func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
