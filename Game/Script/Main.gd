extends YSort

var time = 0;
var endTimer = Save.gameData.time;

func _process(delta):
	time += delta;
	var mins = fmod(time, 60 * 60) / 60;
	if mins >= endTimer:
		get_tree().paused = true;
		return get_tree().change_scene("res://Menu/Victory.tscn");

