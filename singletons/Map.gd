extends Navigation2D



enum TileState {
	Free,
	Blocked,
	Barrier
}

onready var tile_map := $TileMap
onready var warn_timer := $WarnTimer



func get_path_entity(from : Vector2, to : Entity) -> PoolVector2Array:
	var path := get_simple_path(from, to.global_position)
	return path



func get_path_position(from : Vector2, to : Vector2) -> PoolVector2Array:
	var path := get_simple_path(from, to)
	return path



func toggle_tile(tile_pos : Vector2) -> void:
	match get_tile_state(tile_pos):
		TileState.Blocked: set_tile_state(TileState.Free, tile_pos)
		_: set_tile_state(TileState.Blocked, tile_pos)



func update_barriers(tile_pos : Vector2) -> void:
	var offsets : PoolVector2Array = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
	
	for offset in offsets:
		if get_tile_state(tile_pos + offset) == -1:
			tile_map.set_cellv(tile_pos + offset, TileState.Barrier)



func set_tile_state(state : int, tile_pos : Vector2) -> void:
	tile_map.set_cellv(tile_pos, state)
	update_barriers(tile_pos)



func get_tile_state(tile_pos : Vector2) -> int:
	var state : int = tile_map.get_cellv(tile_pos)
	return state



func get_tile_coords(real_pos : Vector2) -> Vector2:
	return tile_map.world_to_map(real_pos)



func get_real_coords(tile_pos : Vector2) -> Vector2:
	return tile_map.map_to_world(tile_pos)



func game_set_tile(state : int, tile_pos : Vector2) -> void:
	AudioManager.play_sfx("warning", tile_map.map_to_world(tile_pos))
	var warning := warn(tile_pos)
	warn_timer.start()
	yield(warn_timer, "timeout")
	warning.queue_free()
	set_tile_state(state, tile_pos)



func warn(tile_pos : Vector2) -> WarningTile:
	var warning_packed := load("res://objects/WarningTile.tscn")
	var warning_instance : WarningTile = warning_packed.instance()
	
	warning_instance.position = tile_map.map_to_world(tile_pos) + Vector2(16, 16)
	warning_instance.default_pos = tile_map.map_to_world(tile_pos) + Vector2(16, 16)
	
	add_child(warning_instance)
	return warning_instance



func generate_map(width : int, height : int) -> void:
	for x in width:
		for y in height:
			set_tile_state(TileState.Free, Vector2(x, y))
