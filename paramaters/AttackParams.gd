# AttackParams is used for creating paramaters when calling `attack` in
# CombatManager.gd.
#
# To create a new paramater, the following are required:
# - It must extend `AttackParams`.
# - It must set `type` to an enum value in `Types`.
# - It must have an `_init(...)` method with the paramaters you'd like your
#	attack to have.
#
# Attack logic is not handled here, this is only a means for passing paramaters
# for your attack.

extends Object
class_name AttackParams



enum Types { SWING, POUND }

var type : int



class Swing extends AttackParams:
	var position : Vector2
	var rotation : float
	
	func _init(set_position : Vector2, set_rotation : float) -> void:
		position = set_position
		rotation = set_rotation



class Pound extends AttackParams:
	var position : Vector2
	var radius : float
	
	func _init(set_position : Vector2, set_radius : float) -> void:
		position = set_position
		radius = set_radius
