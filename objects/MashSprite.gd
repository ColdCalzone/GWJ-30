extends Node2D



enum Heads { Goblin, Archer, Thief, Bub }
enum Torso { Robe, TankTop, Sweaty, Joe }
enum Legs { Robe, Boxers, RobotLeg, Car }

onready var animation := $AnimationPlayer

onready var head_sprite := $Head
onready var torso_sprite := $Torso
onready var legs_sprite := $Legs

var head : int
var torso : int
var legs : int



func _ready() -> void:
	set_moving(false)
	full_randomize()



func full_randomize() -> void:
	randomize_outfit()
	randomize_colors()
	update_textures()



func randomize_outfit() -> void:
	head = randi() % 4
	torso = randi() % 4
	legs = randi() % 4



func randomize_colors() -> void:
	head_sprite.modulate = Color(randf(), randf(), randf())
	torso_sprite.modulate = Color(randf(), randf(), randf())
	legs_sprite.modulate = Color(randf(), randf(), randf())



func update_textures() -> void:
	head_sprite.frame = head
	torso_sprite.frame = torso
	legs_sprite.frame = legs



func reset_anim_parts() -> void:
	head_sprite.rotation_degrees = 0
	torso_sprite.rotation_degrees = 0
	legs_sprite.rotation_degrees = 0
	
	head_sprite.position.y = -8
	torso_sprite.position.y = 0
	legs_sprite.position.y = 8



func toggle_moving() -> void:
	if animation.current_animation == "moving": set_moving(false)
	elif animation.current_animation == "standing": set_moving(true)



func set_moving(value : bool) -> void:
	if value && !is_playing("moving"):
		reset_anim_parts()
		animation.play("moving")
	elif !value && !is_playing("standing"):
		reset_anim_parts()
		animation.play("standing")



func is_playing(anim_name : String) -> bool:
	if animation.current_animation == anim_name:
		return true
	return false
