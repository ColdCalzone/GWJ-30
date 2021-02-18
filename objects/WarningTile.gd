extends AnimatedSprite
class_name WarningTile



onready var animation_player_flash := $Flash
onready var tween := $Tween

var default_pos := Vector2.ZERO



func _ready() -> void:
	play()
	wobble()



func wobble() -> void:
	while true:
		var rand_offset := Vector2(rand_range(-2.0, 2.0), rand_range(-2.0, 2.0))
		var time := 0.1 / default_pos.distance_to(rand_offset)
		tween.interpolate_property(self, "position", default_pos, default_pos + rand_offset, time, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
		tween.start()
		
		yield(tween, "tween_completed")
