extends Attack



onready var animated_sprite := $Sprite
onready var attack_timer := $Timer

var pierces := 0
var direction : Vector2

const SPEED := 560
const MAX_PIERCES := 3



func attack(parameters : AttackParams) -> void:
	position = parameters.position
	rotation_degrees = parameters.rotation
	direction = parameters.direction
	
	AudioManager.play_sfx("swish", global_position)
	
	attack_timer.start()
	yield(attack_timer, "timeout")
	
	ParticleManager.spawn(PulseParticleParams.new(global_position))
	queue_free()



func _process(delta : float) -> void:
	position += SPEED * direction * delta



func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if body is Entity:
		if body != attacker:
			damage(body)
			pierces += 1
			if pierces == MAX_PIERCES: queue_free()
