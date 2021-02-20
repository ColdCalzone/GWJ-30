extends Attack



onready var animated_sprite := $AnimatedSprite
onready var attack_timer := $Timer



func attack(parameters : AttackParams) -> void:
	position = parameters.position
	rotation_degrees = parameters.rotation
	
	animated_sprite.play("default")
	AudioManager.play_sfx("swish", global_position)
	
	attack_timer.start()
	yield(attack_timer, "timeout")
	queue_free()



func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if body is Entity:
		if body != attacker:
			damage(body)
