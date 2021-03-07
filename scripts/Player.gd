extends KinematicBody2D

export var speed = 25000
export var bulletSpeed = 35000
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
	motion = move_and_slide(motion * speed * delta)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LMB"):
		fire(delta)
	
func fire(delta):
	var bulletInstance = bullet.instance()
	bulletInstance.position = get_global_position()
	#bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.rotation_degrees = rand_range(0, 360)
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed,0).rotated(rotation) * delta)
	get_tree().get_root().call_deferred("add_child", bulletInstance) # queing function

func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
