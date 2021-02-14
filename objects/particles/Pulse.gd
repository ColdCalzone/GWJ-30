extends ParticlesEXT



onready var particle_timer := $Timer



func start(parameters : ParticleParams) -> void:
	position = parameters.position
	emitting = true
	
	particle_timer.start()
	yield(particle_timer, "timeout")
	queue_free()
