extends Node2D
class_name Attack



var attacker : Entity
var attacked : Array
var on_beat : bool



# Virtuals
func attack(parameters : AttackParams) -> void: pass
# EOF: Virtuals



func damage(victim : Entity) -> void:
	if attacker != null:
		var final_damage := attacker.attack_damage
		var weapon := attacker.weapon
		
		if attacker.is_in_group("player") && on_beat && !weapon.timer.time_left:
			final_damage += weapon.weapon_data.get("damage")
		elif attacker.is_in_group("enemy"):
			final_damage += weapon.weapon_data.get("damage")
		
		weapon.reset_timer.start()
		
		victim.damage(final_damage)
		attacked.append(victim)
