extends MarginContainer

var game = preload("res://scenes/World.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var currentSelection = 0

func _ready():
	setCurrentSelection(0)

func _process(delta):
	if Input.is_action_just_pressed("down"):
		currentSelection += 1
		setCurrentSelection(currentSelection)
	elif Input.is_action_just_pressed("up"):
		currentSelection -= 1
		setCurrentSelection(currentSelection)
	elif Input.is_action_just_pressed("ui_accept"):
		handleSelection(currentSelection)

func handleSelection(selection):
	if selection == 0:
		get_parent().add_child(game.instance())
		queue_free()
	elif selection == 2:
		get_tree().quit()
		
func setCurrentSelection(selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	match selection:
		0:
			selector_one.text = ">"
		1: 
			selector_two.text = ">"
		2:
			selector_three.text = ">"
