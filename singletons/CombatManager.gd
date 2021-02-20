# Used for managing combat (duh).
#
# To create a new attack which can be used, do the following:
# - Go to `AttackParams.gd` and follow instructions for creating a new attack
#	paramater.
# - Create your attack's scene. (Ensure the attack's script extends `Attack`)
#
# To call an attack, simply do `CombatManager.attack(AttackParams.new(ex, 2x))`
# where `AttackParams.new()` is replaced with your chosen attack paramaters, and
# `ex`/`ex2` are your custom paramaters you want to use. For example,
# ```CombatManager.attack(AttackParams.Swing(position, 45))```

extends Node2D



const ATT_SWING := preload("res://objects/attacks/Swing.tscn")
const ATT_JAB := preload("res://objects/attacks/Jab.tscn")
const ATT_ARROW := preload("res://objects/attacks/Arrow.tscn")



func attack(attacker : Entity, parameters : AttackParams) -> void:
	
	var attack_packed : PackedScene
	
	match parameters.type:
		AttackParams.Types.SWING: attack_packed = ATT_SWING
		AttackParams.Types.JAB: attack_packed = ATT_JAB
		AttackParams.Types.ARROW: attack_packed = ATT_ARROW
	
	var attack_instance := attack_packed.instance()
	add_child(attack_instance)
	
	attack_instance.attacker = attacker
	attack_instance.attack(parameters)


#
#func _input(event) -> void:
#	if event.is_action_pressed("ui_accept"):
#		attack(Entity.new(), SwingAttackParams.new(Vector2.ZERO, 0.06))
