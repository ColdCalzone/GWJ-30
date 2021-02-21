extends Entity



export var target_player_distance_min : float
export var target_player_distance_max : float

onready var attack_timer := $AttackTimer
onready var tween := $Tween
onready var target := get_random_player()



func _ready() -> void:
	health = max_health
	attack_damage = 2
	set_weapon("bow")



func _process(delta : float) -> void:
	get_safe_distance()
	pathfinding()



func get_safe_distance() -> void:
	if distance_to(target) < target_player_distance_min:
		move(global_position - target.global_position)
		attack_timer.start()
	elif distance_to(target) > target_player_distance_max:
		pathfind_entity(target)
		attack_timer.start()
	else:
		clear_path()
		attempt_attack()



func attempt_attack() -> void:
	if !attack_timer.time_left:
		attack_timer.start()
		
		var angle := rad2deg(get_angle_to(target.global_position))
		var direction := Vector2(cos(deg2rad(angle)), sin(deg2rad(angle)))
		weapon.use(ArrowAttackParams.new(global_position, angle, direction))



func damaged() -> void:
	tween.stop_all()
	tween.interpolate_property(self, "rotation_degrees", [-27, 27][randi() % 2], 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()



func die() -> void:
	ParticleManager.spawn(PulseParticleParams.new(global_position))
	game.add_kill()
	queue_free()
