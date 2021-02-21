extends Entity

# A good bit of this code is from https://github.com/ColdCalzone/GWJ27/
# Did rework, take Cold's word with a grain of salt. - Zack

export(float) var speed: float = 5.0
export(float) var acceleration: float = 1.0
export(float) var friction: float = 1.0
export(float) var attack_range: float = 1.0
export(float) var speed_adren: float = 7.5
export(float) var adren_rate: float = 1.0
export(float) var max_adren: float = 200.0
export(float) var adren_time: float = 10.0
var current_adren: float = 0.0

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
# For use later, when the Event type gets added
#not lookin forward to that lol
var action_buffer: Array = []

onready var mash_sprite = $MashSprite
onready var animations = $Animations
onready var collision = $Collision
onready var camera = $Camera
onready var camera_pulse = $Camera/Pulse
onready var tween = $Tween
onready var adrenaline_tween = $AdrenalineTween

const GAMEOVER_SCENE := preload("res://scenes/Gameover.tscn")



func _ready() -> void:
	attack_damage = 2
	health = max_health
	set_weapon("slap")



func _process(delta : float) -> void:
	update_health()



func _physics_process(delta : float) -> void:
	input_movement()
	apply_movement()
	camera_behavior()



func _input(event) -> void:
	if event.is_action_pressed("attack"): weapon.use(get_global_mouse_position())
	if event.is_action_pressed("adrenaline"): attempt_adrenaline()



func input_movement() -> void:
	direction = Vector2.ZERO
	
	var inp_left := Input.is_action_pressed("move_left")
	var inp_right := Input.is_action_pressed("move_right")
	var inp_up := Input.is_action_pressed("move_up")
	var inp_down := Input.is_action_pressed("move_down")
	
	direction.x += int(inp_right) - int(inp_left)
	direction.y += int(inp_down) - int(inp_up)



func apply_movement() -> void:
	if direction.length() != 0:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.y = lerp(velocity.y, direction.y * speed, acceleration)
		velocity = velocity.normalized()
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		velocity.y = lerp(velocity.y, 0, friction)
	
	move_and_collide(velocity * speed)



func camera_behavior() -> void:
	camera.position = (get_viewport().get_mouse_position() - OS.get_window_size() / 2.0) / 16.0
	
	if Heartbeat.is_in_range():
		camera_pulse.play("pulse")



func attempt_adrenaline() -> void:
	if !adrenaline_tween.is_active() && current_adren == max_adren:
		adrenaline_tween.interpolate_property(self, "current_adren", max_adren, 0, adren_time)
		adrenaline_tween.start()
		
		var rem_speed := speed
		
		Heartbeat.bpm = 120.0
		GlobalData.adrenaline_rush = true
		speed = speed_adren
		
		yield(adrenaline_tween, "tween_completed")
		
		Heartbeat.bpm = 60.0
		GlobalData.adrenaline_rush = false
		speed = rem_speed



func add_adrenaline(amount : int) -> void:
	current_adren = clamp(current_adren + amount, 0, max_adren)



func update_health() -> void:
	health = clamp(health, 0, max_health)



func damaged() -> void:
	tween.stop_all()
	tween.interpolate_property(self, "rotation_degrees", [-27, 27][randi() % 2], 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(self, "modulate", Color.red, Color.white, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()



func die() -> void:
	AudioManager.rocken_music.stop()
	tween.interpolate_property(camera, "position", camera.position, Vector2.ZERO, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	TransitionManager.transition(GAMEOVER_SCENE)
