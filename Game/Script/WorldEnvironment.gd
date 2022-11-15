extends WorldEnvironment

func _ready():
	GlobalSettings.connect("brigthness", self, "_on_update_brightness");

func _on_update_brigthness(value):
	environment.adjustment_brightness = value;
