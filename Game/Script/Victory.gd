extends Control

func _ready():
	$Button.grab_focus();

func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn");

func _on_Button2_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn");
