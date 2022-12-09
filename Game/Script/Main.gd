extends YSort

var time = 0;
var endTimer = Save.gameData.time;

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			return get_tree().change_scene("res://Menu/Pause.tscn");

func _process(delta):
	time += delta;
	var mins = fmod(time, 60 * 60) / 60;
	if mins >= endTimer:
		return get_tree().change_scene("res://Menu/Victory.tscn");
