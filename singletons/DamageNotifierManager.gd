extends Node2D



const DAMAGE_PACKED := preload("res://objects/DamageNotifier.tscn")



func list_damage(amount : int, set_position : Vector2, entity : Entity) -> void:
	var node := Node2D.new()
	node.position = set_position
	
	var dmg_noti_instace := DAMAGE_PACKED.instance()
	
	if entity.is_in_group("enemy"):
		dmg_noti_instace.set("custom_colors/font_color", Color.yellow)
	else:
		dmg_noti_instace.set("custom_colors/font_color", Color.black)
	
	add_child(node)
	node.add_child(dmg_noti_instace)
	dmg_noti_instace.text = str(amount)
