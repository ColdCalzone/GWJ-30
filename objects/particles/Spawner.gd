extends ParticlesEXT



var target : Node2D



func start(params : ParticleParams) -> void:
	target = params.target



func _process(delta : float) -> void:
	position = target.global_position
	free_check()



func free_check() -> void:
	if target.is_queued_for_deletion():
		queue_free()
