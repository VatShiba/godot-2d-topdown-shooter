extends KinematicBody2D

const speed = 200
export var maxHp = 300
var target = null
var hp = null
onready var sprite = $Sprite
onready var healthBar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar.value = 100
	hp = maxHp
	pass # Replace with function body.
	
func _process(delta):
	if(hp <= 0):
		queue_free()
	
func _physics_process(delta):
	if target:
		var motion = global_position.direction_to(target.global_position)
		sprite.look_at(target.position)
		move_and_slide(motion * speed)

func _on_AggroArea_body_entered(body):
	if body.name == "Player":
		target = body

func _on_AggroArea_body_exited(body):
	if body.name == "Player":
		target = null

func damage(point):
	hp -= point
	updateHealthbar()
	print((hp / maxHp)*100)
	
func updateHealthbar():
	healthBar.value = (hp / maxHp)*100
