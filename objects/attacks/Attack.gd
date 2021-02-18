extends Node2D
class_name Attack



var attacker : Entity



# Virtuals
func attack(parameters : AttackParams) -> void: pass
# EOF: Virtuals



func damage(victim : Entity) -> void:
	victim.damage(attacker.attack_damage)
