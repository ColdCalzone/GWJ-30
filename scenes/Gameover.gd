extends Control



onready var waves_label := $VBoxContainer/Stats/Waves
onready var kills_label := $VBoxContainer/Stats/Kills



func _ready() -> void:
	Map.tile_map.clear()



func _on_Button_pressed() -> void:
	TransitionManager.transition(load("res://scenes/Game.tscn"))
