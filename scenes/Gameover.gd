extends Control



onready var waves_label := $VBoxContainer/Stats/Waves
onready var kills_label := $VBoxContainer/Stats/Kills

const TITLE_SCREEN := preload("res://scenes/Titlescreen.tscn")



func _ready() -> void:
	Map.tile_map.clear()



func _on_Button_pressed() -> void:
	TransitionManager.transition(TITLE_SCREEN)
