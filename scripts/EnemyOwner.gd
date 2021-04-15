extends Node2D

onready var enemy = $Enemy

func _physics_process(delta):
	# Tracking Healthbar on top kineticbody2d
	$HealthBar.set_global_position(Vector2(enemy.global_position.x - 25 , \
	enemy.global_position.y - (enemy.get_node("Sprite").texture.get_size().y / 2) \
	- 20 ))
	
	# Tracking AggroArea
	$AggroArea.set_global_position(enemy.global_position)
