extends Node

signal fps(value);

func togglefullscreen(value):
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if value else Window.MODE_WINDOWED
	Save.gameData.fullscreen_on = value;
	Save.save_data();

func toggleVsync(value):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if value else DisplayServer.VSYNC_DISABLED)
	Save.gameData.vsync_on = value;
	Save.save_data();

func displayFps(value):
	emit_signal("fps", value);
	Save.gameData.display_fps = value;
	Save.save_data();

func setMaxFps(value):
	Engine.max_fps = value if value < 500 else 0;
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
	upEvent.keycode = OS.find_keycode_from_string(Save.gameData.input.Up);
	InputMap.action_add_event("Up", upEvent);

	var downEvent = InputEventKey.new();
	downEvent.keycode = OS.find_keycode_from_string(Save.gameData.input.Down);
	InputMap.action_add_event("Down", downEvent);

	var leftEvent = InputEventKey.new();
	leftEvent.keycode = OS.find_keycode_from_string(Save.gameData.input.Left);
	InputMap.action_add_event("Left", leftEvent);

	var rightEvent = InputEventKey.new();
	rightEvent.keycode = OS.find_keycode_from_string(Save.gameData.input.Right);
	InputMap.action_add_event("Right", rightEvent);
