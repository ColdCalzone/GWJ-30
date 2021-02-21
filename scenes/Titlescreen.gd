extends Control

onready var play = $MenuCenter/MenuVBox/Play
onready var exit = $MenuCenter/MenuVBox/Exit

onready var game = load("res://scenes/Game.tscn")
onready var exit_workaround = load("res://scenes/Exit.tscn")

func _ready():
	play.connect("pressed", self, "button_pressed", ["play"])
	exit.connect("pressed", self, "button_pressed", ["exit"])

func button_pressed(id : String):
	match id:
		"play": TransitionManager.transition(game)
		"exit": TransitionManager.transition(exit_workaround)

func _on_Help_pressed():
	pass # Replace with function body.
