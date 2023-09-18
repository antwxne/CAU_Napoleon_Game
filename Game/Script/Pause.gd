extends Control

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			visible = true;
			get_tree().paused = true;
			$VBoxContainer/Play.grab_focus();

func _on_Play_pressed():
	visible = false;
	get_tree().paused = false;

func _on_Settings_pressed():
	visible = false;
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://Menu/SettingsMenu.tscn");

func _on_MainMenu_pressed():
	visible = false;
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://Menu/Menu.tscn");

func _on_Left_pressed():
	get_tree().quit();
