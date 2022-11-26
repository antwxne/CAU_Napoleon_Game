extends Control

onready var videoMode = $TabContainer/Video/GridContainer/VideoMode
onready var checkVsync = $TabContainer/Video/GridContainer/CheckVsync
onready var checkFps = $TabContainer/Video/GridContainer/CheckFps
onready var sliderFps = $TabContainer/Video/GridContainer/HBoxContainer/SliderFps

onready var sliderMaster = $TabContainer/Audio/GridContainer/SliderMaster
onready var sliderMusic = $TabContainer/Audio/GridContainer/SliderMusic
onready var sliderVfx = $TabContainer/Audio/GridContainer/SliderVFX


var tab = 0;
var tabsFocus;

func _ready():
	$TabContainer/Video/GridContainer/VideoMode.grab_focus();
	tabsFocus = [$TabContainer/Video/GridContainer/VideoMode, $TabContainer/Audio/GridContainer/SliderMaster, $TabContainer/Gameplay/GridContainer/Up/ButtonUp]

	videoMode.select(1 if Save.gameData.fullscreen_on else 0);
	GlobalSettings.togglefullscreen(Save.gameData.fullscreen_on);
	checkVsync.pressed = Save.gameData.vsync_on;
	checkFps.pressed = Save.gameData.display_fps;
	sliderFps.value = Save.gameData.max_fps;
	
	sliderMaster.value = Save.gameData.master_vol;
	sliderMusic.value = Save.gameData.music_vol;
	sliderVfx.value = Save.gameData.vfx_vol;
	#var keynode = get_node("res://pressAKey").get_node("Keypressed");
	#print(keynode);
	#keynode.connect("updateKeyUp", self, "_updateKeyUp");
	#GlobalSettings.connect("updateKeyDown", self, "_updateKeyDown");
	#GlobalSettings.connect("updateKeyRight", self, "_updateKeyRight");
	#GlobalSettings.connect("updateKeyLeft", self, "_updateKeyLeft");

func _process(delta):
	if Input.is_action_just_pressed("ui_change_tab"):
		tab = 0 if tab == 2 else tab + 1;
		$TabContainer.set_current_tab(tab);
		tabsFocus[tab].grab_focus();

func _on_Return_pressed():
	get_tree().change_scene("res://Menu.tscn");

func _on_VideoMode_item_selected(index):
	GlobalSettings.togglefullscreen(true if index == 1 else false);

func _on_CheckVsync_toggled(button_pressed):
	GlobalSettings.toggleVsync(button_pressed);

func _on_CheckFps_toggled(button_pressed):
	GlobalSettings.displayFps(button_pressed);

func _on_SliderFps_value_changed(value_changed):
	GlobalSettings.setMaxFps(value_changed);

func _on_SliderMaster_value_changed(value_changed):
	GlobalSettings.updateVol(0, value_changed);


func _on_SliderMusic_value_changed(value_changed):
	GlobalSettings.updateVol(1, value_changed);


func _on_SliderSFX_value_changed(value_changed):
	GlobalSettings.updateVol(2, value_changed);


func _on_Up_text_entered(new_text):
	print(new_text);
	GlobalSettings.updateShortcut(new_text, "Up");

func _on_ButtonUp_pressed():
	get_tree().change_scene("res://pressAKey.tscn");

func _on_ButtonDown_pressed():
	get_tree().change_scene("res://pressAKey.tscn");


func _on_ButtonLeft_pressed():
	get_tree().change_scene("res://pressAKey.tscn");


func _on_ButtonRight_pressed():
	get_tree().change_scene("res://pressAKey.tscn");

func _updateKeyUp(value):
	print("test")
	print(value);
	Save.gameData.up = value;
	Save.save_data();

func _updateKeyDown(value):
	Save.gameData.down = value;
	Save.save_data();

func _updateKeyRight(value):
	Save.gameData.right = value;
	Save.save_data();

func _updateKeyLeft(value):
	Save.gameData.left = value;
	Save.save_data();
