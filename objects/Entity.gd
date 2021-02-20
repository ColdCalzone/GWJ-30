extends KinematicBody2D
class_name Entity



export var max_health : int
export var move_speed : int

var health : int
var attack_damage : int
var path : PoolVector2Array
var target_point : Vector2

const PATH_POINT_THREASHOLD := 4



# Virtuals
func die() -> void: pass
func damaged() -> void: pass
# EOF: Virtuals



func _process(delta : float) -> void:
	pathfinding()



func distance_to(entity : Entity) -> float:
	var result := global_position.distance_to(entity.global_position)
	return result



func get_random_player() -> Entity:
	var players : Array = get_tree().get_nodes_in_group("player")
	var result : Entity = players[randi() % len(players)]
	
	return result



func get_random_enemy() -> Entity:
	var enemies : Array = get_tree().get_noeds_in_group("enemy")
	var result : Entity = enemies[randi() % len(enemies)]
	
	return result



func damage(amount : int) -> void:
	health = clamp(health - amount, 0, max_health)
	damaged()
	
	if !health: die()



func pathfind_entity(target : Entity) -> void:
	path = Map.get_path_entity(global_position, target)



func pathfind(to : Vector2) -> void:
	path = Map.get_path_position(global_position, to)



func clear_path() -> void:
	path = [] as PoolVector2Array



func pathfinding() -> void:
	if len(path):
		target_point = path[0]
		
		move((target_point - global_position).normalized())
		
		if global_position.distance_to(target_point) < PATH_POINT_THREASHOLD:
			path.remove(0)



func move(direction : Vector2) -> void:
	move_and_slide(direction.normalized() * move_speed)
