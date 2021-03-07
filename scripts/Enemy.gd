extends KinematicBody2D

const speed = 200
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if target:
		var motion = global_position.direction_to(target.global_position)
		look_at(target.position)
		move_and_collide(motion * speed * delta)

func _on_AggroArea_body_entered(body):
	if body.name == "Player":
		target = body

func _on_AggroArea_body_exited(body):
	if body.name == "Player":
		target = null

func _on_Hitbox_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
