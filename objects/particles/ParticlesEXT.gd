extends CPUParticles2D
class_name ParticlesEXT



signal stopped()



# Virtuals
func start(params : ParticleParams) -> void: pass
# EOF: Virtuals



func stop() -> void:
	emitting = false
	emit_signal("stopped")
