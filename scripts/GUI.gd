extends Control

onready var playerDamageLabel = $PlayerDamageLabel
onready var playerVariables = $"/root/PlayerVariables"
func _ready():
	playerDamageLabel.text = "Player Damage Range: " \
	+ PoolStringArray(playerVariables.damageRange).join(",")
	pass # Replace with function body.
