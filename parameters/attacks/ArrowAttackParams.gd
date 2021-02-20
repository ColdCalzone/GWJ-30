extends AttackParams
class_name ArrowAttackParams



var position : Vector2
var rotation : float
var direction : Vector2



func _init(set_position : Vector2, set_rotation : float, set_direction : Vector2) -> void:
	position = set_position
	rotation = set_rotation
	direction = set_direction
	
	damage_multiplier = 1.0
	
	type = Types.ARROW
