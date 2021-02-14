extends Node2D
class_name Attack



var attacker : Entity



# Virtuals
func attack(paramaters : AttackParams) -> void: pass
# EOF: Virtuals



func damage(victim : Entity) -> void:
	print("lol")
#	victim.damage(attacker.attack_damage)
