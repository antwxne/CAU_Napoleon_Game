extends Node

signal fps(value);
signal brightness_updated(value);
signal mouse_sens(value);

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
	
func updateShortcut(value, action):
	pass
