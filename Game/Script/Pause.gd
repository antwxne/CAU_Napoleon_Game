extends Node

func _ready():
	$VBoxContainer/Play.grab_focus();

func _on_Play_pressed():
	get_tree().change_scene("res://Main.tscn");

func _on_Settings_pressed():
	get_tree().change_scene("res://SettingsMenu.tscn");

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Menu.tscn");

func _on_Left_pressed():
	get_tree().quit();
