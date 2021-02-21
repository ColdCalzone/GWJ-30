extends Entity



export var target_player_distance : float

onready var target := get_random_player()
onready var attack_timer := $AttackTimer
onready var tween := $Tween
onready var mash_sprite := $MashSprite



func _ready() -> void:
	mash_sprite.head_sprite.frame = MashSprite.Heads.Bub
	health = max_health
	attack_damage = 3
	set_weapon(["longsword", "brass_knuckles", "cymbals"][randi() % 3])



func _process(delta : float) -> void:
	get_near_player()
	pathfinding()



func get_near_player() -> void:
	if distance_to(target) <= target_player_distance:
		clear_path()
		attempt_attack()
	else:
		pathfind_entity(target)
		attack_timer.start()



func attempt_attack() -> void:
	if !attack_timer.time_left:
		attack_timer.start()
		
		weapon.use(target.global_position)



func damaged() -> void:
	tween.stop_all()
	tween.interpolate_property(self, "rotation_degrees", [-27, 27][randi() % 2], 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()



func die() -> void:
	ParticleManager.spawn(PulseParticleParams.new(global_position))
	game.add_kill()
	queue_free()
