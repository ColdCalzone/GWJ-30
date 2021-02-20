extends Sprite
class_name Weapon



enum AnimationTypes { Swipe, Jab }

onready var animation_player := $AnimationPlayer
onready var anchor := $Anchor
onready var sprite := $Anchor/Sprite
onready var timer := $Timer

var weapon_data : Dictionary



func _ready() -> void:
	sprite.position.x = sprite.texture.get_width() / 2.0
	timer.wait_time = weapon_data.cooldown



func use(animation_type : int) -> void:
	if !timer.time_left:
		timer.start()
		animation(animation_type)



func animation(animation_type : int) -> void:
	match animation_type:
		AnimationTypes.Swipe: animation_player.play("swipe")
		AnimationTypes.Jab: animation_player.play("jab")



func reset_animation() -> void:
	rotation_degrees = 0
	position = Vector2.ZERO



func _on_AnimationPlayer_animation_finished(anim_name):
	reset_animation()
