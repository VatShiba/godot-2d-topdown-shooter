extends Node

onready var playerVariables = get_node("/root/PlayerVariables")

func damageCalculate():
	var damage = rand_range(playerVariables.damageRange[0],playerVariables.damageRange[1])
	return int(round(damage))
