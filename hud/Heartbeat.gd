extends Control



onready var heart_sprite := $Gradient/Heartbeat
onready var arrow := $Gradient/Arrow

const LENGTH := 136



func _ready() -> void:
	Heartbeat.connect("beat", self, "beat")



func _process(delta : float) -> void:
	arrow.rect_position.x = (Heartbeat.metric * LENGTH / 2.0) + LENGTH / 2.0



func beat() -> void:
	heart_sprite.frame = 0
	heart_sprite.play("default")
