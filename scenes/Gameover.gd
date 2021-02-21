extends Control



onready var waves_label := $VBoxContainer/Stats/Waves
onready var kills_label := $VBoxContainer/Stats/Kills

const TITLE_SCREEN := preload("res://scenes/Titlescreen.tscn")



func _ready() -> void:
	Map.tile_map.clear()
	waves_label.text = "Waves Survived: %s" % [GlobalData.waves_survived]
	kills_label.text = "Enemies killed: %" % [GlobalData.enemies_killed]



func _on_Button_pressed() -> void:
	TransitionManager.transition(TITLE_SCREEN)
