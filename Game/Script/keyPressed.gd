extends Node

signal updateKeyUp(value);

func _ready():
	pass

func _input(value):
	print(value);
	emit_signal("updateKeyUp", value);
	get_tree().change_scene("res://SettingsMenu.tscn");
