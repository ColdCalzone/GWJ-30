extends CanvasLayer



onready var animation_player := $AnimationPlayer



func transition(desired_scene : PackedScene) -> void:
	animation_player.play("fade_in")
	yield(animation_player, "animation_finished")
	get_tree().change_scene_to(desired_scene)
	animation_player.play("fade_out")
