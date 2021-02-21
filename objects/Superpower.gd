extends Node2D
class_name Superpower



export var modifying_variable : String
export var amount : int



func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if body != null:
		if body.is_in_group("player"):
			body.set(modifying_variable, body.get(modifying_variable) + amount)
			queue_free()
