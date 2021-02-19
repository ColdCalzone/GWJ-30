extends ParticleParams
class_name SpawnerParticleParams



var target : Node2D



func _init(set_target : Node2D) -> void:
	target = set_target
	
	type = Types.SPAWNER
