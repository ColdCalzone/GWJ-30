extends ParticleParams
class_name WeaponReadyParticleParams



var position : Vector2



func _init(set_position : Vector2) -> void:
	position = set_position
	
	type = Types.WEAPON_READY
