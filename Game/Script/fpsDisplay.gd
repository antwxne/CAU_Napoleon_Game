extends Label

func _ready():
	GlobalSettings.connect("fps", self, "_on_fps");

func _process(delta):
	text = "FPS: %s" % [Engine.get_frames_per_second()]

func _on_fps(value):
	visible = value;
