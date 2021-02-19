extends Node2D



export var max_spawns : int
export var time_min : float
export var time_max : float
export (Array, PackedScene) var entities : Array

onready var target := global_position
onready var world := get_parent()
onready var timer := $Timer

var spawns := []
var direction := Vector2.ZERO

const DISTANCE_THRESHOLD := 4.0



func _ready() -> void:
	ParticleManager.spawn(SpawnerParticleParams.new(self))
	set_timer()



func _process(delta : float) -> void:
	apply_movement(delta)



func set_timer() -> void:
	timer.wait_time = rand_range(time_min, time_max)
	timer.start()



func move_to(to : Vector2) -> void:
	target = to



func apply_movement(delta : float) -> void:
	direction = target - global_position
	global_position += direction * delta
	if global_position.distance_to(target) < DISTANCE_THRESHOLD: global_position = target



func spawn_entity() -> void:
	if len(spawns) < max_spawns:
		var desired_entity : Entity = entities[randi() % len(entities)].instance()
		spawns.append(desired_entity)
		desired_entity.connect("tree_exiting", self, "entity_deleted")
		world.add_child(desired_entity)
		desired_entity.global_position = global_position
		set_timer()



func entity_deleted() -> void:
	pass



func _on_Timer_timeout():
	spawn_entity()
