extends ParticlesEXT



var target : Node2D



func start(params : ParticleParams) -> void:
	target = params.target



func _process(delta : float) -> void:
	if target != null: position = target.global_position
	else: queue_free()
