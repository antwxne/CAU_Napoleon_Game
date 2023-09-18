extends Control

func _ready():
	$Button.grab_focus();

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn");

func _on_Button2_pressed():
	get_tree().change_scene_to_file("res://Menu/Menu.tscn");
