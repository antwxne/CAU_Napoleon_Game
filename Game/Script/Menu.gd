extends Node

func _ready():
	Save.load_data();
	$VBoxContainer/Play.grab_focus();
	GlobalSettings.togglefullscreen(Save.gameData.fullscreen_on);
	GlobalSettings.toggleVsync(Save.gameData.vsync_on);
	GlobalSettings.setMaxFps(Save.gameData.max_fps);
	GlobalSettings.updateVol(0, Save.gameData.master_vol);
	GlobalSettings.updateVol(1, Save.gameData.music_vol);
	GlobalSettings.updateVol(2, Save.gameData.vfx_vol);
	GlobalSettings.updateShortcut();
	$Label.text = "Gold: " + str(Save.gameData.player.gold);

func _on_Play_pressed():
	get_tree().change_scene("res://Main.tscn");

func _on_Player_Stats_pressed():
	get_tree().change_scene("res://StatsMenu.tscn");

func _on_Settings_pressed():
	get_tree().change_scene("res://SettingsMenu.tscn");

func _on_Exit_pressed():
	get_tree().quit();
