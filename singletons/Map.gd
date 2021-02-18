extends Navigation2D



enum TileState {
	Free,
	Blocked
}

onready var tile_map := $TileMap



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



func set_tile_state(state : int, tile_pos : Vector2) -> void:
	tile_map.set_cellv(tile_pos, state)



func get_tile_state(tile_pos : Vector2) -> int:
	var state : int = tile_map.get_cellv(tile_pos)
	return state



func get_tile_coords(real_pos : Vector2) -> Vector2:
	return tile_map.world_to_map(real_pos)



func get_real_coords(tile_pos : Vector2) -> Vector2:
	return tile_map.map_to_world(tile_pos)
