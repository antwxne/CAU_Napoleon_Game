extends CharacterBody2D

@export var movement_speed = 95.0
@export var hp = 20
@export var knockback_recovery = 3.5
@export var experience = 15
var knockback = Vector2.ZERO

@onready var dmg = $AnimatedSprite2D/Damage
@onready var sprite = $AnimatedSprite2D
@onready var anim = $AnimatedSprite2D
@onready var player = get_tree().get_nodes_in_group("player")[0]

var xp_scene = preload("res://Utiles/xp.tscn")
var coin_scene = preload("res://Utiles/coin.tscn")

func _ready():
	anim.play("walk")

func _physics_process(_delta):
	if hp <= 0:
		death();
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	if player and is_instance_valid(player):
		if str(player)=="[Deleted Object]":
			return;
		var direction = global_position.direction_to(player.global_position)
		var local_velocity = direction*movement_speed
		local_velocity += knockback
		set_velocity(local_velocity)
		move_and_slide()
		
		if direction.x > 0.1:
			sprite.flip_h = true
		elif direction.x < -0.1:
			sprite.flip_h = false

func death():
	queue_free();
	var xp = xp_scene.instantiate();
	xp.xp = experience;
	xp.global_position = global_position;
	get_tree().get_root().add_child(xp);
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	if rng.randi_range(0, 5) == 5:
		var coin = coin_scene.instantiate();
		coin.global_position = global_position;
		coin.global_position.y += 15;
		get_tree().get_root().add_child(coin);
	
