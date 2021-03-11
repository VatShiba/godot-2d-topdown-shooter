extends KinematicBody2D

const speed = 200
var randomMaxHpRange = [0, 500]
var maxHp = null
var target = null
var hp = null
onready var sprite = $Sprite
onready var healthBar = get_owner().get_node("HealthBar")
var floatingText = preload("res://scenes/GUI/FloatingText.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar.value = 100
	init()

func init():
	randomize()
	# Random Scale
	var randomScale = rand_range(0.7, 2)
	self.scale = Vector2(randomScale, randomScale)
	
	# Random HP
	maxHp = rand_range(randomMaxHpRange[0], randomMaxHpRange[1])
	hp = maxHp
	# Random Sprite Color of Enemies
	sprite.modulate = Color(randf(), randf(), randf())

func _physics_process(delta):
	if target:
		var motion = global_position.direction_to(target.global_position)
		look_at(target.position)
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
	var textInstance = floatingText.instance()
	textInstance.amount = damagePoint
	textInstance.position = global_position
	get_tree().get_root().add_child(textInstance)
	
	updateHealthbar()
	if(hp <= 0):
		killed()
		
func killed():
	get_owner().queue_free()
	
func updateHealthbar():
	healthBar.value = (hp / maxHp)*100

func _on_Hitbox_body_entered(body):
	var damageFunction = get_node("/root/DamageFunction")
	if "Bullet" in body.name:
		if(body.isActive):
			call_deferred("onHit", damageFunction.damageCalculate())
			body.isActive = false
