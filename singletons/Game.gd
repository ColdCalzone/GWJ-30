extends Node2D



onready var wave_timer = $WaveTimer

var wave_quota := 0
var wave := 0
var quota_multiplier := 0
var spawners := []
var wave_kills := 0
var total_kills := 0
var wave_enemies := 0

const ENEMY1_PACKED := preload("res://objects/enemies/Enemy1.tscn")
const PLAYER_PACKED := preload("res://objects/Player.tscn")
const SPAWNER_PACKED := preload("res://objects/Spawner.tscn")

const ENTITY_SIZE := Vector2(64, 64)
const MAP_SIZE := Vector2(35, 20)
const ENEMY_WAVES := {
	[ENEMY1_PACKED]: 0
}



func _ready() -> void:
	setup()



func setup() -> void:
	reset_map()
	AudioManager.play_music("rocken")
	spawn_player(Vector2(MAP_SIZE.x * 32.0 / 2.0, MAP_SIZE.y * 32.0 / 2.0))
	new_wave()



func new_wave() -> void:
	# Reset stuff
	wave_enemies = 0
	wave_kills = 0
	
	reset_map()
	
	wave_timer.start()
	yield(wave_timer, "timeout")
	
	# Update wave quota
	wave += 1
	quota_multiplier = max(randf() * 5.0, 2.0)
	wave_quota = round(wave * quota_multiplier)
	
	# Add new spawners
	for i in int(rand_range(2, 5)):
		var x_spawn := rand_range(0, MAP_SIZE.x * 32)
		var y_spawn := rand_range(0, MAP_SIZE.y * 32)
		add_spawner(Vector2(x_spawn, y_spawn))



func spawn_entity(entity_scene : PackedScene, set_position : Vector2) -> Entity:
	var entity_instance : Entity = entity_scene.instance()
	add_child(entity_instance)
	
	entity_instance.position = set_position
	
	return entity_instance



func spawn_player(set_position : Vector2) -> void:
	spawn_entity(PLAYER_PACKED, set_position)



func spawn_enemy(enemy : PackedScene, set_position : Vector2) -> Entity:
	if wave_enemies < wave_quota:
		wave_enemies += 1
		var result : Entity = spawn_entity(enemy, set_position)
		return result
	return null



func add_spawner(set_position : Vector2) -> void:
	var spawner_instance := SPAWNER_PACKED.instance()
	
	spawner_instance.position = set_position
	spawner_instance.time_min = 2.0
	spawner_instance.time_max = 4.0
	spawner_instance.entities = ENEMY_WAVES.keys()[0]
#	while true:
#		spawner_instance.entities = ENEMY_WAVES.keys()[randi() % len(ENEMY_WAVES)]
#		if wave >= ENEMY_WAVES.get(spawner_instance.entities): break
	
	add_child(spawner_instance)
	spawners.append(spawner_instance)
	update_spawners_max_spawns()



func clear_spawners() -> void:
	for s in spawners:
		s.queue_free()
	spawners = []



func move_spawners() -> void:
	for s in spawners:
		var x_target := rand_range(0, MAP_SIZE.x * 32)
		var y_target := rand_range(0, MAP_SIZE.y * 32)
		s.move_to(Vector2(x_target, y_target))



func update_spawners_max_spawns() -> void:
	for s in spawners:
		s.max_spawns = wave_quota / int(len(spawners))
	
	for i in wave_quota % int(len(spawners)):
		spawners[i % len(spawners)].max_spawns += 1



func add_kill() -> void:
	wave_kills += 1
	total_kills += 1
	
	if wave_kills == wave_quota:
		new_wave()



func reset_map() -> void:
	Map.generate_map(MAP_SIZE.x, MAP_SIZE.y)



func generate_random_spots(state : int, min_size : Vector2, max_size : Vector2) -> void:
	var base := Vector2(
		round(rand_range(0, MAP_SIZE.x)),
		round(rand_range(0, MAP_SIZE.y))
	)
	
	var size := Vector2(
		round(rand_range(min_size.x, max_size.x)),
		round(rand_range(min_size.y, max_size.y))
	)
	
	base.x -= size.x
	base.y -= size.y
	
	for x in size.x:
		for y in size.y:
			
			if x + base.x in range(0, MAP_SIZE.x):
				if abs(y + base.y) in range(0, MAP_SIZE.y):
					Map.game_set_tile(state, Vector2(x + base.x, y + base.y))



# Not working, too late to bother fixing it
func in_occupied_tile(check_pos : Vector2) -> bool:
	for entity in get_tree().get_nodes_in_group("entity"):
		var top_left : Vector2 = entity.global_position - ENTITY_SIZE
		var bottom_right : Vector2 = entity.global_position + ENTITY_SIZE
		
		top_left = Map.tile_map.world_to_map(top_left)
		bottom_right = Map.tile_map.world_to_map(bottom_right)
		
		for x in range(top_left.x, bottom_right.x):
			for y in range(top_left.y, bottom_right.y):
				if Map.get_tile_state(Vector2(x, y)) != Map.TileState.Free:
					return false
	
	return true



func _on_MoveSpawnersTimer_timeout() -> void:
	move_spawners()



func _on_MapRandomTimer_timeout():
	reset_map()
	for _i in range(0, 4):
		generate_random_spots(Map.TileState.Blocked, Vector2(2, 2), Vector2(8, 8))
