extends Node2D
class_name Weapon



enum AttackTypes { Swipe, Jab, Arrow, Clang }

onready var animation_player := $AnimationPlayer
onready var anchor := $Anchor
onready var sprite := $Anchor/Sprite
onready var timer := $Timer
onready var cooldown_timer := $Cooldown
onready var reset_timer := $ResetTimer
onready var tween := $Tween

var weapon_name : String
var weapon_data : Dictionary
var handler # I HATE DYNAMIC BUT I HATE DUMB ERRORS MORE



func _ready() -> void:
	sprite.texture = load(weapon_data.texture)
#	sprite.position.x = sprite.texture.get_width() / 2.0
	timer.wait_time = weapon_data.cooldown
	timer.start()



func _process(delta : float) -> void:
	sprite.look_at(get_global_mouse_position())



func use(target_position : Vector2) -> void:
	if !cooldown_timer.time_left:
		cooldown_timer.start()
		attack(target_position)



func gray_out() -> void:
	tween.stop_all()
	tween.interpolate_property(sprite, "modulate", Color(0.1, 0.1, 0.1), Color(1.0, 1.0, 1.0), weapon_data.cooldown)
	tween.start()



func attack(target_position : Vector2) -> void:
	match int(weapon_data.attack_type):
		AttackTypes.Swipe:
			var angle := rad2deg(get_angle_to(target_position))
			var offset := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))) * 40
			CombatManager.attack(handler, SwingAttackParams.new(global_position + offset, angle + 90))
		AttackTypes.Jab:
			var angle := rad2deg(get_angle_to(target_position))
			var offset := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))) * 40
			CombatManager.attack(handler, JabAttackParams.new(global_position + offset, angle))
		AttackTypes.Arrow:
			var angle := rad2deg(get_angle_to(target_position))
			var direction := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle)))
			CombatManager.attack(handler, ArrowAttackParams.new(global_position, angle, direction))
		AttackTypes.Clang:
			CombatManager.attack(handler, ClangAttackParams.new(global_position))



func animation() -> void:
	match int(weapon_data.attack_type):
		AttackTypes.Swipe: animation_player.play("swipe")
		AttackTypes.Jab: animation_player.play("jab")



func reset_animation() -> void:
	rotation_degrees = 0
	position = Vector2.ZERO



func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	reset_animation()



func _on_ResetTimer_timeout() -> void:
	timer.start()
	gray_out()


func _on_Tween_tween_completed(_object : Object, _key : NodePath) -> void:
	animation_player.play("glow")
	ParticleManager.spawn(WeaponReadyParticleParams.new(global_position))
