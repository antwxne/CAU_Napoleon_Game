extends Label

func _ready():
	GlobalSettings.connect("fps", Callable(self, "_on_fps"));
	visible = Save.gameData.display_fps;
	return connect;

func _process(_delta):
	text = "FPS: %s" % [Engine.get_frames_per_second()]

func _on_fps(value):
	visible = value;
