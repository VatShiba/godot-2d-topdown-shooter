extends KinematicBody2D

const speed = 200
var randomMaxHpRange = [0, 500]
var maxHp = null
var target = null
var hp = null
onready var sprite = $Sprite
onready var healthBar = $HealthBar
var floatingText = preload("res://scenes/GUI/FloatingText.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar.value = 100
	maxHp = rand_range(randomMaxHpRange[0], randomMaxHpRange[1])
	hp = maxHp
	# Random Sprite Color of Enemies
	sprite.modulate = Color(randf(), randf(), randf())
	
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

func onHit(damagePoint):
	hp -= damagePoint
	
	# Text popup
	var text = floatingText.instance()
	text.amount = damagePoint
	text.position = global_position
	get_owner().add_child(text)
	
	updateHealthbar()
	if(hp <= 0):
		killed()
		
func killed():
	queue_free()
	
func updateHealthbar():
	healthBar.value = (hp / maxHp)*100

func _on_Hitbox_body_entered(body):
	var damageFunction = get_node("/root/DamageFunction")
	if "Bullet" in body.name:
		call_deferred("onHit", damageFunction.damageCalculate())
