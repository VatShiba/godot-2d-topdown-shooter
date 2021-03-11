extends Position2D

onready var timer = $Timer
var enemy = preload("res://scenes/Enemy.tscn")

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout") 
	timer.start()

func _on_timer_timeout():
	# call enemy
	var enemyInstance = enemy.instance()
	enemyInstance.position = global_position
	get_owner().call_deferred("add_child", enemyInstance)
	print("Enemy here")
	pass
