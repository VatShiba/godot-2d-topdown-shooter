extends Node

onready var playerVariables = get_node("/root/PlayerVariables")

func damageCalculate():
	return rand_range(playerVariables.damageRange[0],playerVariables.damageRange[1])
