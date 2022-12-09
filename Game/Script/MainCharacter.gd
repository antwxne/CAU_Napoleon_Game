extends KinematicBody2D

export (int) var speed = 200

onready var _animated_sprite = $AnimatedSprite

export var velocity = Vector2()

var spear = preload("res://Weapons/Spear.tscn");

onready var spearTimer = get_node("%Timer");
onready var spearAttackTimer = get_node("%SpearAttackTimer");

signal xp(value);

var spearAmmo = 0;
var spearBaseAmmo = 1;
var spearSpeed = 0.1;
var spearLevel = 1;

var armor = 0;
var health = 50 + Save.gameData.player.health * 10;
var xp = 0;
var max_xp = 50;

var enemyClose = [];

func _ready():
	attack();

func attack():
	if spearLevel > 0:
		spearTimer.wait_time = spearSpeed;
		if spearTimer.is_stopped():
			spearTimer.start();

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("Down"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = 0;
		$ParticuleMove.direction.y = -1;
		velocity.y += 1
		_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Right"):
			$ParticuleMove.direction.x = -1;
			velocity.x += 1
			_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Left"):
			$ParticuleMove.direction.x = 1;
			velocity.x -= 1
			_animated_sprite.play("down_direction")
	elif Input.is_action_pressed("Up"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = 0;
		$ParticuleMove.direction.y = 1;
		velocity.y -= 1
		_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Right"):
			$ParticuleMove.direction.x = -1;
			velocity.x += 1
			_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Left"):
			$ParticuleMove.direction.x = 1;
			velocity.x -= 1
			_animated_sprite.play("up_direction")
	elif Input.is_action_pressed("Left"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = 1;
		$ParticuleMove.direction.y = 0;
		velocity.x -= 1
		_animated_sprite.play("left_direction")
	elif Input.is_action_pressed("Right"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = -1;
		$ParticuleMove.direction.y = 0;
		velocity.x += 1
		_animated_sprite.play("right_direction")
	else:
		$ParticuleMove.emitting = false;
		_animated_sprite.play("idle")

	velocity = velocity.normalized() * speed


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_SpearAttackTimer_timeout():
	if spear > 0:
		var spearAttack = spear.instance();
		spearAttack.position = position;
		spearAttack.traget = getRandomTarget();
		spearAttack.level = spearLevel;
		add_child(spearAttack);
		spearAmmo -= 1;
		if spearAmmo > 0:
			spearAttackTimer.start();
		else:
			spearAttackTimer.stop();

func getRandomTarget():
	pass

func _on_SpearTimer_timeout():
	spearAmmo += spearBaseAmmo;
	spearAttackTimer.start();

func _on_hurtbox_hurt(damage, _angle, _knockback):
	health -= clamp(damage - armor, 1.0, 999.0);
	if health <= 0:
		death()

func death():
	return get_tree().change_scene("res://Menu/Loose.tscn");

func on_xp(value):
	emit_signal("xp", value);
	xp += value;
	if xp >= max_xp:
		xp -= max_xp;
		max_xp += 10;
	#call level up
