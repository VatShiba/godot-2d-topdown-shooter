extends RigidBody2D

func _ready():
	yield(get_tree().create_timer(1.5),"timeout")
	queue_free()


func _on_Area2D_body_entered(body):
	queue_free()
