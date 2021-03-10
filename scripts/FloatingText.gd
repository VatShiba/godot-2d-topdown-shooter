extends Position2D

onready var label = $Label
onready var tween = $Tween
var amount = 0

var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(amount))
	
	randomize()
	var sideMovement = randi() % 81 - 40 # -40 to 40
	velocity = Vector2(sideMovement, -50)
	
	tween.interpolate_property(self, "scale", scale, Vector2(1, 1), \
	.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(.1, .1), \
	.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, .3)
	tween.start()

func _process(delta):
	position += velocity * delta

func _on_Tween_tween_all_completed():
	queue_free()
