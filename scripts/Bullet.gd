extends RigidBody2D


func _ready():
	yield(get_tree().create_timer(1),"timeout")
	if(is_instance_valid(get_tree())):
		queue_free()

func _on_Area2D_body_entered(body):
	var damageFunction = get_node("/root/DamageFunction")
	if body.is_in_group("Enemy"):
		body.damage(damageFunction.damageCalculate())
		#body.call_deferred("queue_free")
		call_deferred("queue_free")
	#rotation = rotation.reflect(ray.get_collision_normal())
