extends RigidBody2D

var isActive = true

func _ready():
	yield(get_tree().create_timer(1),"timeout")
	if(is_instance_valid(get_tree())):
		call_deferred("queue_free")
