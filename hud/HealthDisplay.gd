extends Control



onready var display := $Control/Display
onready var player : Entity = get_tree().get_nodes_in_group("player")[0]



func _process(_delta : float) -> void:
	display.text = "%s/%s" % [player.health, player.max_health]
