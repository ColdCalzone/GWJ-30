extends Control



func _on_Timer_timeout() -> void:
	get_parent().queue_free()
