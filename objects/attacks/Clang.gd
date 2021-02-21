extends Attack



onready var animated_sprite := $AnimatedSprite
onready var timer := $Timer



func attack(parameters : AttackParams) -> void:
	position = parameters.position
	
	animated_sprite.play("default")
	AudioManager.play_sfx("cymbal", global_position)
	
	timer.start()
	yield(timer, "timeout")
	queue_free()



func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if body is Entity:
		if body != attacker:
			damage(body)
