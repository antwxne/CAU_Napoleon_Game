extends Node

signal fps(value);

func togglefullscreen(value):
	OS.window_fullscreen = value;
	Save.gameData.fullscreen_on = value;
	Save.save_data();

func toggleVsync(value):
	OS.vsync_enabled = value;
	Save.gameData.vsync_on = value;
	Save.save_data();

func displayFps(value):
	emit_signal("fps", value);
	Save.gameData.display_fps = value;
	Save.save_data();

func setMaxFps(value):
	Engine.target_fps = value if value < 500 else 0;
	Save.gameData.max_fps = value if value < 500 else 0;
	Save.save_data();

func updateVol(canal, vol):
	AudioServer.set_bus_volume_db(canal, vol);
	if canal == 0:
		Save.gameData.master_vol = vol;
	if canal == 1:
		Save.gameData.music_vol = vol;
	if canal == 2:
		Save.gameData.vfx_vol = vol;
	Save.save_data();
	
func updateShortcut():
	var upEvent = InputEventKey.new();
	upEvent.scancode = OS.find_scancode_from_string(Save.gameData.input.Up);
	InputMap.action_add_event("Up", upEvent);

	var downEvent = InputEventKey.new();
	downEvent.scancode = OS.find_scancode_from_string(Save.gameData.input.Down);
	InputMap.action_add_event("Down", downEvent);

	var leftEvent = InputEventKey.new();
	leftEvent.scancode = OS.find_scancode_from_string(Save.gameData.input.Left);
	InputMap.action_add_event("Left", leftEvent);

	var rightEvent = InputEventKey.new();
	rightEvent.scancode = OS.find_scancode_from_string(Save.gameData.input.Right);
	InputMap.action_add_event("Right", rightEvent);
