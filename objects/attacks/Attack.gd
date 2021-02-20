extends Node2D
class_name Attack



var attacker : Entity
var attacked : Array



# Virtuals
func attack(parameters : AttackParams) -> void: pass
# EOF: Virtuals



func damage(victim : Entity) -> void:
	if attacker != null:
		var final_damage := attacker.attack_damage
		var weapon := attacker.weapon
		
		if attacker.is_in_group("player") && Heartbeat.is_in_range() && !weapon.timer.time_left:
			final_damage += weapon.weapon_data.get("damage")
		elif attacker.is_in_group("enemy"):
			final_damage += weapon.weapon_data.get("damage")
		
		victim.damage(final_damage)
		attacked.append(victim)
