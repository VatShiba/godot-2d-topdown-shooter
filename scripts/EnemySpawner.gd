extends Position2D

onready var timer = $Timer
var enemy = preload("res://scenes/Enemy.tscn")
var floatingText = preload("res://scenes/generator/FloatingText.tscn")
var active = true

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout") 
	if(active):
		timer.start()

func _on_timer_timeout():
	# Call enemy
	var enemyInstance = enemy.instance()
	enemyInstance.position = global_position
	get_owner().call_deferred("add_child", enemyInstance)
	
	# Text popup
	var textInstance = floatingText.instance()
	textInstance.amount = "@"
	textInstance.position = global_position
	get_tree().get_root().call_deferred("add_child", textInstance)
	textInstance = floatingText.instance()
	textInstance.amount = "#"
	textInstance.position = global_position
	get_tree().get_root().call_deferred("add_child", textInstance)
