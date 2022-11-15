extends Node

signal fps(value);
signal brigthness(value);
signal mouse_sens(value);

func togglefullscreen(value):
	OS.window_fullscreen = value;

func toggleVsync(value):
	OS.vsync_enabled = value;

func displayFps(value):
	emit_signal("fps", value);

func setMaxFps(value):
	Engine.target_fps = value if value < 500 else 0;

func updateBrigthness(value):
	emit_signal("brigthness", value);

func updateMasterVol(vol):
	AudioServer.set_bus_volume_db(0, vol);
	
func updateMouseSens(value):
	emit_signal("mouse_sens", value);
