extends ProgressBar



onready var player : Entity = get_tree().get_nodes_in_group("player")[0]



func _process(delta : float) -> void:
	max_value = player.max_adren
	value = player.current_adren
