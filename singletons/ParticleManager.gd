extends Node2D



const PART_PULSE := preload("res://objects/particles/Pulse.tscn")
const PART_SPAWNER := preload("res://objects/particles/Spawner.tscn")
const PART_W_READY := preload("res://objects/particles/WeaponReady.tscn")



func spawn(parameters : ParticleParams) -> void:
	
	var particles_packed : PackedScene
	
	match parameters.type:
		ParticleParams.Types.PULSE: particles_packed = PART_PULSE
		ParticleParams.Types.SPAWNER: particles_packed = PART_SPAWNER
		ParticleParams.Types.WEAPON_READY: particles_packed = PART_W_READY
	
	var particles_instance := particles_packed.instance()
	add_child(particles_instance)
	
	particles_instance.start(parameters)



#func _input(event) -> void:
#	if event.is_action_pressed("ui_accept"):
#		spawn(PulseParticleParams.new(Vector2.ZERO))
