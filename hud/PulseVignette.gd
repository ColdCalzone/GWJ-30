extends Control



onready var animation := $AnimationPlayer



func _ready() -> void:
	Heartbeat.connect("beat", self, "beat")



func beat() -> void:
	animation.play("pulse")
