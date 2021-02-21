extends Control



onready var hud := get_parent()

const MENU := preload("res://scenes/Titlescreen.tscn")

var is_paused := false



func _input(event : InputEvent) -> void:
	if event.is_action_pressed("pause"): toggle_pause()



func toggle_pause() -> void:
	match is_paused:
		true: set_is_paused(false)
		false: set_is_paused(true)



func set_is_paused(value : bool) -> void:
	match value:
		true:
			get_tree().paused = true
			is_paused = true
			visible = true
		false:
			get_tree().paused = false
			is_paused = false
			visible = false



func _on_ContinueButton_pressed() -> void:
	set_is_paused(false)



func _on_EndGameButton_pressed() -> void:
	set_is_paused(false)
	TransitionManager.transition(MENU)
