extends AttackParams
class_name SwingAttackParams



var position : Vector2
var rotation : float



func _init(set_position : Vector2, set_rotation : float) -> void:
	position = set_position
	rotation = set_rotation
	
	damage_multiplier = 1.0
	
	type = Types.SWING
