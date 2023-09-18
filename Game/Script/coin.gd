extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0];
@export var movement_speed = 142.0;
var no_move = true;
@export var gold = 1;

func _ready():
	pass;

func _process(_delta):
	if player and is_instance_valid(player) and !no_move:
		var direction = global_position.direction_to(player.global_position)
		var local_velocity = direction * movement_speed
		set_velocity(local_velocity)
		move_and_slide()

		if direction.x > 0.1:
			$sprite_xp.flip_h = true
		elif direction.x < -0.1:
			$sprite_xp.flip_h = false

func _on_xp_body_entered(body):
	if body.name == "Player":
		no_move = false;

func _on_delete_body_entered(body):
	if body.has_method("on_gold"):
		body.on_gold(gold);
		queue_free()
