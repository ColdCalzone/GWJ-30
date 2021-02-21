extends Entity



export var player_distance : float

onready var player := get_random_player()
onready var target := get_random_target()
onready var attack_timer := $AttackTimer
onready var tween := $Tween
onready var mash_sprite := $MashSprite



func _ready() -> void:
	mash_sprite.head_sprite.frame = MashSprite.Heads.Thief
	health = max_health
	attack_damage = 1
	
	set_weapon("shortsword")



func _process(delta : float) -> void:
	steal_treasures()
	get_near_player()
	attack_near_players()
	pathfinding()



func steal_treasures() -> void:
	if target != null:
		pathfind(target.global_position)
	else:
		target = get_random_target()



func get_near_player() -> void:
	if target == null:
		if distance_to(player) <= player_distance:
			clear_path()
		else:
			pathfind_entity(player)



func attack_near_players() -> void:
	for p in get_tree().get_nodes_in_group("player"):
		if distance_to(p) <= player_distance:
			attempt_attack(p)
			break



func attempt_attack(target_player : Entity) -> void:
	if !attack_timer.time_left:
		attack_timer.start()
		
		weapon.use(target_player)



func get_random_target() -> WeaponPickup:
	var result : WeaponPickup = null
	
	if len(get_tree().get_nodes_in_group("pickup")):
		result = get_tree().get_nodes_in_group("pickup")[randi() % len(get_tree().get_nodes_in_group("pickup"))]
		if result.cooldown.time_left || self in result.area2d.get_overlapping_bodies():
			result = null
	
	return result



func damaged() -> void:
	tween.stop_all()
	tween.interpolate_property(self, "rotation_degrees", [-27, 27][randi() % 2], 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()



func die() -> void:
	ParticleManager.spawn(PulseParticleParams.new(global_position))
	game.add_kill()
	queue_free()
