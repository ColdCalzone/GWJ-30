extends Node2D
class_name WeaponPickup



onready var sprite := $Sprite
onready var cooldown := $CooldownTimer
onready var area2d := $Area2D

var weapon_name : String



func _ready() -> void:
	update_texture()



func update_texture() -> void:
	sprite.set_texture(load(WeaponManager.get_weapon_data(weapon_name).texture))



func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if body is Entity && !body.dead && !cooldown.time_left:
		body.drop_chance = 1.00
		body.set_weapon(weapon_name)
		queue_free()



func _on_LifeTimer_timeout() -> void:
	ParticleManager.spawn(PulseParticleParams.new(global_position))
	queue_free()
