extends Node2D
class_name Attack



var attacker : Entity
var attacked : Array



# Virtuals
func attack(parameters : AttackParams) -> void: pass
# EOF: Virtuals



func damage(victim : Entity) -> void:
	if attacker != null:
		victim.damage(attacker.attack_damage)
		attacked.append(victim)
