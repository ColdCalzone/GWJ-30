extends Entity



export var target_player_distance : int

onready var attack_timer := $AttackTimer
onready var tween := $Tween

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
		var angle := rad2deg(get_angle_to(target.global_position))
		var offset := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))) * 40
		CombatManager.attack(self, SwingAttackParams.new(global_position + offset, angle + 90))



func damaged() -> void:
	tween.stop_all()
	tween.interpolate_property(self, "rotation_degrees", [-27, 27][randi() % 2], 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
