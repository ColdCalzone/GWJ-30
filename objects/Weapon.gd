extends Node2D
class_name Weapon



enum AttackTypes { Swipe, Jab }

onready var animation_player := $AnimationPlayer
onready var anchor := $Anchor
onready var sprite := $Anchor/Sprite
onready var timer := $Timer

var weapon_data : Dictionary
var handler # I HATE DYNAMIC BUT I HATE DUMB ERRORS MORE



func _ready() -> void:
	sprite.texture = load(weapon_data.texture)
#	sprite.position.x = sprite.texture.get_width() / 2.0
	timer.wait_time = weapon_data.cooldown



func _process(delta : float) -> void:
	sprite.look_at(get_global_mouse_position())



func use() -> void:
	if !timer.time_left:
		timer.start()
		animation()
		attack()



func attack() -> void:
	match int(weapon_data.attack_type):
		AttackTypes.Swipe:
			var angle := rad2deg(get_angle_to(get_global_mouse_position()))
			var offset := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))) * 40
			CombatManager.attack(handler, SwingAttackParams.new(global_position + offset, angle + 90))
		AttackTypes.Jab:
			var angle := rad2deg(get_angle_to(get_global_mouse_position()))
			var offset := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))) * 40
			CombatManager.attack(handler, JabAttackParams.new(global_position + offset, angle))



func animation() -> void:
	match int(weapon_data.attack_type):
		AttackTypes.Swipe: animation_player.play("swipe")
		AttackTypes.Jab: animation_player.play("jab")



func reset_animation() -> void:
	rotation_degrees = 0
	position = Vector2.ZERO



func _on_AnimationPlayer_animation_finished(anim_name):
	reset_animation()
