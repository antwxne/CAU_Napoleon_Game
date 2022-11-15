extends Node


func _ready():
	$VBoxContainer/Play.grab_focus();

func _on_Play_pressed():
	get_tree().change_scene("res://Main.tscn");


func _on_Player_Stats_pressed():
	pass # Replace with function body.


func _on_Settings_pressed():
	get_tree().change_scene("res://SettingsMenu.tscn");


func _on_Exit_pressed():
	get_tree().quit();
