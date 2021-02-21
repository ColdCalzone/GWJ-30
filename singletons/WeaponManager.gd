extends Node



const WEAPON_PACKED := preload("res://objects/Weapon.tscn")
const WEAPONS_DATA := "res://data/weapons.json"



func get_weapon(weapon_name : String) -> Weapon:
	var weapon_data : Dictionary = load_file(WEAPONS_DATA).get(weapon_name)
	var weapon_instance : Weapon = WEAPON_PACKED.instance()
	
	weapon_instance.weapon_data = weapon_data
	weapon_instance.weapon_name = weapon_name
	
	return weapon_instance



func get_weapon_data(weapon_name : String) -> Dictionary:
	var weapon_data : Dictionary = load_file(WEAPONS_DATA).get(weapon_name)
	
	return weapon_data



func load_file(file_to_read : String) -> Dictionary:
	var file := File.new()
	file.open(file_to_read, File.READ)
	
	var file_string_content := file.get_as_text()
	var content : Dictionary = JSON.parse(file_string_content).result
	
	return content



func _ready() -> void:
	pass
