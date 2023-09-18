extends Node

const SAVEFILE = "res://SAVEFILE.save"

var gameData = {}
var defaultGameData = {
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
	}
}

func merge_dicts(base, override):
	var result = base.duplicate()
	for key in override:
		result[key] = override[key]
	return result

func _ready():
	load_data()

func load_data():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		var loadedData = file.get_var()
		gameData = merge_dicts(defaultGameData, loadedData)
		file.close()
	else:
		gameData = defaultGameData.duplicate()
		save_data()

# ... (rest of the script)
func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
#	var file = File.new();
#	file.open(SAVEFILE, file.WRITE);
	file.store_var(gameData);
	file.close();
