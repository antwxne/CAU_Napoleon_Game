extends Node

const MAX_ENEMIES: int = 4

onready var _spawners_location: Array = []
const _enemy_array: Array = [preload("res://enemies/beast.tscn"),
	preload("res://enemies/beholder.tscn"),
	preload("res://enemies/bulette.tscn"),
	preload("res://enemies/Dragon.tscn"),
	preload("res://enemies/golem.tscn"),
	preload("res://enemies/Slime.tscn")];

onready var main_scene = get_tree().get_root();
onready var spawn_timer = get_node("Timers/spawn_timer");
onready var frequency_timer = get_node("Timers/frequency_timer");

func _ready():
	for child in self.get_children():
		if child is Position2D:
			_spawners_location.push_back(child)

func spawn_enemy(enemy_node_array: Array) -> void:
	spawn_timer.stop()

	for enemy_node in enemy_node_array:
		main_scene.add_child(enemy_node)
		yield(frequency_timer, "timeout")
	spawn_timer.start()

func spawn_random_enemy_on_random_spawner() -> void:
	var spawner_position: Position2D = _spawners_location[randi() % _spawners_location.size()];
	var random_enemy_index: int = randi() % _enemy_array.size();
	var random_number_of_enemies = (randi() % MAX_ENEMIES) + 1
	var enemies_to_spawn_array: Array = []

	for n in random_number_of_enemies:
		var new_enemy = _enemy_array[random_enemy_index].instance();
		new_enemy.position = spawner_position.position
		enemies_to_spawn_array.push_back(new_enemy)
	spawn_enemy(enemies_to_spawn_array);
