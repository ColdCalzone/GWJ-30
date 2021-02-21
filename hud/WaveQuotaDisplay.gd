extends Control



onready var wave_display := $VBoxContainer/Wave
onready var quota_display := $VBoxContainer/Quota



func _process(delta : float) -> void:
	wave_display.text = "Wave: %s" % [GlobalData.waves_survived]
	quota_display.text = "Kills: %s / %s" % [GlobalData.wave_enemies_killed, GlobalData.wave_quota]
