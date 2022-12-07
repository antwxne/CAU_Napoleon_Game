extends YSort

var time = 0;
var endTimer = Save.gameData.time;

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://Pause.tscn");

func _process(delta):
	time += delta;
	var mins = fmod(time, 60 * 60) / 60;
	if mins >= endTimer:
		get_tree().change_scene("res://Victory.tscn");
