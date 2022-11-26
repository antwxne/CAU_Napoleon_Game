extends Camera2D

onready var player = get_node("../Player")

func _process(delta):
	position = player.global_position
	var x = floor(position.x)
	var y = floor(position.y)
	global_position = Vector2(x, y)

