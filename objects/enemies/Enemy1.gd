extends Entity



export var target_player_distance : int

onready var attack_timer := $AttackTimer

onready var target := get_random_player()



func _process(delta : float) -> void:
	get_near_player()
	pathfinding()



func get_near_player() -> void:
	if distance_to(target) <= target_player_distance:
		clear_path()
		attempt_attack()
	else:
		pathfind_entity(target)



func attempt_attack() -> void:
	if attack_timer.time_left == 0:
		attack_timer.start()
		CombatManager.attack(self, SwingAttackParams.new(global_position, rad2deg(get_angle_to(target.global_position) + 90)))
