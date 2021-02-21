extends AttackParams
class_name ClangAttackParams



var position : Vector2



func _init(set_position : Vector2) -> void:
	position = set_position
	
	damage_multiplier = 1.0
	
	type = Types.CLANG
