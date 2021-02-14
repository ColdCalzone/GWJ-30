extends Attack



onready var animated_sprite := $AnimatedSprite
onready var attack_timer := $Timer



func attack(paramaters : AttackParams) -> void:
	position = paramaters.position
	rotation_degrees = paramaters.rotation
	
	animated_sprite.play("default")
	
	attack_timer.start()
	yield(attack_timer, "timeout")
	queue_free()



func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if body is Entity:
		if body != attacker:
			damage(body)
			queue_free()
