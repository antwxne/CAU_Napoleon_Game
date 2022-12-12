extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite

export (int) var speed = 200
export var velocity = Vector2();

# Preaload
var spear = preload("res://Weapons/Spear.tscn");
var axe = preload("res://Weapons/Axe.tscn")
var dagger = preload("res://Weapons/Dagger.tscn")

# Attack Timers
onready var spearTimer = get_node("%spearTimer");
onready var spearAttackTimer = get_node("%spearAttackTimer");

onready var axeTimer = get_node("%axeTimer")
onready var axeAttackTimer = get_node("%axeAttackTimer")

onready var daggerTimer = get_node("%daggerTimer")
onready var daggerAttackTimer = get_node("%daggerAttackTimer")

# Signals
signal xp(value);
signal gold(value);
signal weapons(value);
signal level(value);
signal hp(value);

# Player stats
var attack_speed = Save.gameData.player.attack * 0.1 + 1;
var armor = Save.gameData.player.armor * 2;
var health = 40 + Save.gameData.player.health * 10;
var xp = 0;
var max_xp = 30;
var oz = Save.gameData.player.offense_zone;
var weapons = [];

# Weapons stats
var spearAmmo = 0;
var spearBaseAmmo = 1;
var spearSpeed = 1 / attack_speed;
var spearLevel = 1;

var axeAmmo = 0;
var axeBaseAmmo = 2;
var axeSpeed = 1.2 / attack_speed;
var axeLevel = 0;

var daggerAmmo = 0;
var daggerBaseAmmo = 1;
var daggerSpeed = 1 / attack_speed;
var daggerLevel = 0;

var enemyClose = [];

func _ready():
	attack();
	_check_level();

func attack():
	if spearLevel > 0:
		spearTimer.wait_time = spearSpeed;
		if spearTimer.is_stopped():
			spearTimer.start();
	if axeLevel > 0:
		axeTimer.wait_time = axeSpeed;
		if axeTimer.is_stopped():
			axeTimer.start();
	if daggerLevel > 0:
		daggerTimer.wait_time = daggerSpeed
		if daggerTimer.is_stopped():
			daggerTimer.start();

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("Down"):
		velocity.y += 1
		_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Right"):
			velocity.x += 1
			_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
			_animated_sprite.play("down_direction")
	elif Input.is_action_pressed("Up"):
		velocity.y -= 1
		_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Right"):
			velocity.x += 1
			_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
			_animated_sprite.play("up_direction")
	elif Input.is_action_pressed("Left"):
		velocity.x -= 1
		_animated_sprite.play("left_direction")
	elif Input.is_action_pressed("Right"):
		velocity.x += 1
		_animated_sprite.play("right_direction")
	else:
		_animated_sprite.play("idle")
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_hurtbox_hurt(damage, _angle, _knockback):
	health -= clamp(damage - armor, 1.0, 999.0);
	$AnimatedSprite/Damage.emitting = true;
	emit_signal("hp", health);

	if health <= 0:
		death()

func death():
	return get_tree().change_scene("res://Menu/Loose.tscn");

func on_xp(value):
	emit_signal("xp", value);
	xp += value;

	if xp >= max_xp:
		xp -= max_xp;
		max_xp += 20;
		emit_signal("level", [spearLevel, axeLevel, daggerLevel]);

func on_gold(value):
	Save.gameData.player.gold += value;
	Save.save_data();
	emit_signal("gold", value);

func _on_detectEnemies_body_entered(body):
	if body.name != "Player":
		enemyClose.push_back(body);

func find_closest_node_to_point(array, point):
	var closest_node = null
	var closest_node_distance = 0.0

	for i in array:
		var current_node_distance = point.distance_to(i.global_position)

		if closest_node == null or current_node_distance < closest_node_distance:
			closest_node = i
			closest_node_distance = current_node_distance
	return closest_node.global_position

func _on_spearTimer_timeout():
	spearAmmo += spearBaseAmmo;
	spearAttackTimer.start();

func _on_spearAttackTimer_timeout():
	if spearAmmo > 0:
		var spearAttack = spear.instance();
		spearAttack.position = Vector2();

		if enemyClose.size() == 0:
			return;
		spearAttack.target = find_closest_node_to_point(enemyClose, global_position);
		spearAttack.level = spearLevel;
		add_child(spearAttack);
		spearAmmo -= 1;

		if spearAmmo > 0:
			spearAttackTimer.start();
		else:
			spearAttackTimer.stop();

func _on_detectEnemies_body_exited(body):
	var j = 0;
	for i in enemyClose:
		if i == body:
			enemyClose.pop_at(j);
			return;
		j += 1;

func _on_axeTimer_timeout():
	axeAmmo += axeBaseAmmo;
	axeAttackTimer.start();

func _on_axeAttackTimer_timeout():
	if axeAmmo > 0:
		var axeAttack = axe.instance();
		axeAttack.position = Vector2();

		if enemyClose.size() == 0: 
			return;
		axeAttack.target = find_closest_node_to_point(enemyClose, global_position);
		axeAttack.base_pos = global_position;
		axeAttack.level = axeLevel;
		add_child(axeAttack);
		axeAmmo -= 1;
		
		if axeAmmo > 0:
			axeAttackTimer.start();
		else:
			axeAttackTimer.stop();

func _check_level():
	if spearLevel > 0:
		weapons.push_back("spear");
	if axeLevel > 0:
		weapons.push_back("axe");
	if daggerLevel > 0:
		weapons.push_back("dagger");
	emit_signal("weapons", weapons);

func _on_daggerTimer_timeout():
	daggerAmmo += daggerBaseAmmo;
	daggerAttackTimer.start();

func _on_daggerAttackTimer_timeout():
	if daggerAmmo > 0:
		var daggerAttack = dagger.instance();
		daggerAttack.position = Vector2();

		if enemyClose.size() == 0:
			return;
		daggerAttack.target = find_closest_node_to_point(enemyClose, global_position);
		daggerAttack.level = daggerLevel;
		add_child(daggerAttack);
		daggerAmmo -= 1;

		if daggerAmmo > 0:
			daggerAttackTimer.start();
		else:
			daggerAttackTimer.stop();

func _on_levelUp_spearLvlUp(value):
	spearLevel = value;
	spearSpeed -= 0.01; 

func _on_levelUp_axeLvlUp(value):
	axeBaseAmmo += 1;
	axeLevel = value;
	axeSpeed -= 0.01; 
	if axeLevel == 1:
		attack();
		_check_level();
	
func _on_levelUp_daggerLvlUp(value):
	daggerLevel = value;
	daggerSpeed -= 0.05;
	if daggerLevel == 1:
		attack();
		_check_level();
