extends KinematicBody2D

# A good bit of this code is from https://github.com/ColdCalzone/GWJ27/

export(float) var speed: float = 5.0
export(float) var acceleration: float = 1.0
export(float) var friction: float = 1.0
export(float) var attack_range: float = 1.0
export(float) var adren_rate: float = 1.0
export(float) var max_adren: float = 200.0
var current_adren: float = 0.0

var velocity : Vector2 = Vector2.ZERO
# For use later, when the Event type gets added
#not lookin forward to that lol
var action_buffer: Array = []

onready var sprite = $Sprite
onready var animations = $Animations
onready var collision = $Collision
onready var camera = $Camera

func _physics_process(delta : float):
	var dir: Vector2 = Vector2.ZERO
	# Input code
	if Input.is_action_pressed("move_up"):
		dir += Vector2.UP
	if Input.is_action_pressed("move_down"):
		dir += Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		dir += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		dir += Vector2.RIGHT
	
	# Movement
	if dir.length() != 0:
		velocity.x = lerp(velocity.x, dir.x * speed, acceleration)
		velocity.y = lerp(velocity.y, dir.y * speed, acceleration)
		velocity = velocity.normalized()
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		velocity.y = lerp(velocity.y, 0, friction)
		
	move_and_collide(velocity * speed)
	# Create aiming effect
	camera.position = (get_viewport().get_mouse_position() - OS.get_window_size()/2)/16
	
