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
var is_waiting_for_key: bool = false setget set_is_waiting_for_key
var action = "";

func _on_Button_pressed():
	self.is_waiting_for_key = true;
	
func set_is_waiting_for_key(next_is_waiting_for_key: bool):
	is_waiting_for_key = next_is_waiting_for_key;
	if is_waiting_for_key:
		$press_a_key_label.show();
	else:
		$press_a_key_label.hide();

func _unhandled_input(event):
	if not is_waiting_for_key: return;
	
	if event is InputEventKey and event.is_pressed():
		accept_event();
		set_action_key(action, event.as_text());
		self.is_waiting_for_key = false;
		update_label();

func set_action_key(target_action: String, key: String):
	for event in InputMap.get_action_list(target_action):
		if event is InputEventKey:
			InputMap.action_erase_event(target_action, event);
	var next_event = InputEventKey.new();
	next_event.scancode = OS.find_scancode_from_string(key);
	InputMap.action_add_event(target_action, next_event);
	if target_action == "Up":
		Save.gameData.input.Up = key;
	if target_action == "Down":
		Save.gameData.input.Down = key;
	if target_action == "Left":
		Save.gameData.input.Left = key;
	if target_action == "Right":
		Save.gameData.input.Right = key;
	Save.save_data();
	return OK;

func _ready():
	$TabContainer/Video/GridContainer/VideoMode.grab_focus();
	tabsFocus = [$TabContainer/Video/GridContainer/VideoMode, $TabContainer/Audio/GridContainer/SliderMaster, $TabContainer/Gameplay/GridContainer/Up/ButtonUp]

	self.is_waiting_for_key = false
	videoMode.select(1 if Save.gameData.fullscreen_on else 0);
	GlobalSettings.togglefullscreen(Save.gameData.fullscreen_on);
	checkVsync.pressed = Save.gameData.vsync_on;
	checkFps.pressed = Save.gameData.display_fps;
	sliderFps.value = Save.gameData.max_fps;
	
	sliderMaster.value = Save.gameData.master_vol;
	sliderMusic.value = Save.gameData.music_vol;
	sliderVfx.value = Save.gameData.vfx_vol;

	update_label();

func _process(_delta):
	if Input.is_action_just_pressed("ui_change_tab"):
		tab = 0 if tab == 2 else tab + 1;
		$TabContainer.set_current_tab(tab);
		tabsFocus[tab].grab_focus();

func _on_Return_pressed():
	return get_tree().change_scene("res://Menu/Menu.tscn");

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

func _on_ButtonUp_pressed():
	action = "Up";
	self.is_waiting_for_key = true;

func _on_ButtonDown_pressed():
	action = "Down";
	self.is_waiting_for_key = true;

func _on_ButtonLeft_pressed():
	action = "Left";
	self.is_waiting_for_key = true;

func _on_ButtonRight_pressed():
	action = "Right";
	self.is_waiting_for_key = true;

func update_label():
	$TabContainer/Gameplay/GridContainer/Up/Label.text = Save.gameData.input.Up + "  ";
	$TabContainer/Gameplay/GridContainer/Down/Label.text = Save.gameData.input.Down + "  ";
	$TabContainer/Gameplay/GridContainer/Left/Label.text = Save.gameData.input.Left + "  ";
	$TabContainer/Gameplay/GridContainer/Right/Label.text = Save.gameData.input.Right + "  ";
