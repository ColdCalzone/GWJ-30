extends Node



var bpm := 60.0
var metric := 0.0
var direction := 1

onready var step := bpm / 60.0

const MIN := -1
const MAX := 1
const THRESHOLD := 0.25

signal beat()



func _process(delta : float) -> void:
	metric(delta)



func metric(delta : float) -> void:
	metric = clamp(metric + step * direction * delta * 2.0, MIN, MAX)
	if is_in_range():
		emit_signal("beat")
	
	if metric in [MIN, MAX]:
		direction *= -1



func is_in_range() -> bool:
	if metric > -THRESHOLD && metric < THRESHOLD:
		return true
	return false
