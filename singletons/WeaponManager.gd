extends Node



const WEAPON_PACKED := preload("res://objects/Weapon.tscn")
const WEAPONS_DATA := "res://data/weapons.json"



func get_weapon(weapon_name : String) -> Weapon:
	var weapon_data := load_file(WEAPONS_DATA)
	var weapon_instance : Weapon = WEAPON_PACKED.instanced()
	
	weapon_instance.sprite.texture = load(weapon_data.texture)
	weapon_instance.weapon_data = {
		"damage": weapon_data.damage,
		"cooldown": weapon_data.cooldown,
		"attack_type": weapon_data.attack_type
	}
	
	return weapon_instance



func load_file(file_to_read : String) -> Dictionary:
	var file := File.new()
	file.open(file_to_read, File.READ)
	
	var file_string_content := file.get_as_text()
	var content : Dictionary = JSON.parse(file_string_content).result
	
	return content



func _ready() -> void:
	pass
