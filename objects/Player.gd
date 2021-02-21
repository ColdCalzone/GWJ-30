extends Entity

# A good bit of this code is from https://github.com/ColdCalzone/GWJ27/
# Did rework, take Cold's word with a grain of salt. - Zack

export(float) var speed: float = 5.0
export(float) var acceleration: float = 1.0
export(float) var friction: float = 1.0
export(float) var attack_range: float = 1.0
export(float) var adren_rate: float = 1.0
export(float) var max_adren: float = 200.0
var current_adren: float = 0.0

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
# For use later, when the Event type gets added
#not lookin forward to that lol
var action_buffer: Array = []

onready var sprite = $Sprite
onready var animations = $Animations
onready var collision = $Collision
onready var camera = $Camera
onready var camera_pulse = $Camera/Pulse



func _ready() -> void:
	attack_damage = 2
	set_weapon("slap")



func _physics_process(delta : float):
	input_movement()
	apply_movement()
	camera_behavior()



func _input(event) -> void:
	if event.is_action_pressed("attack"): weapon.use()



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
