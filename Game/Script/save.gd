extends Node

const SAVEFILE = "res://SAVEFILE.save"

var gameData = {}

func _ready():
	load_data();

func load_data():
	var file = File.new();
	if not file.file_exists("SAVEFILE.save"):
		gameData = {
			"fullscreen_on": false,
			"vsync_on": false,
			"display_fps": false,
			"max_fps": 0,
			"master_vol": -10,
			"music_vol": -10,
			"vfx_vol": -10,
			"time": 2,
			"input": {
				"Up": "W",
				"Down": "S",
				"Right": "D",
				"Left": "A",
			},
			"player": {
				"gold": 10,
				"health": 0,
				"attack": 0,
				"offense_zone": 0,
				"armor": 0,
			},
		}
		save_data();
	file.open(SAVEFILE, file.READ);
	gameData = file.get_var();
	file.close();

func save_data():
	var file = File.new();
	file.open(SAVEFILE, file.WRITE);
	file.store_var(gameData);
	file.close();
