extends KinematicBody2D

export (int) var speed = 200

onready var _animated_sprite = $AnimatedSprite

export var velocity = Vector2();

var spear = preload("res://Weapons/Spear.tscn");
var tornado = preload("res://Weapons/Tornado.tscn")
var mama = preload("res://Weapons/Mama.tscn")

onready var spearTimer = get_node("%spearTimer");
onready var spearAttackTimer = get_node("%spearAttackTimer");

onready var tornadoTimer = get_node("%tornadoTimer")
onready var tornadoAttackTimer = get_node("%tornadoAttackTimer")

onready var mamaTimer = get_node("%mamaTimer")
onready var mamaAttackTimer = get_node("%mamaAttackTimer")

signal xp(value);
signal gold(value);
signal weapons(value);
signal level(value);

var attack_speed = Save.gameData.player.attack * 0.1 + 1;
var armor = Save.gameData.player.armor * 2;
var health = 40 + Save.gameData.player.health * 10;
var xp = 0;
var max_xp = 50;
var oz = Save.gameData.player.offense_zone;
var weapons = [];

var spearAmmo = 0;
var spearBaseAmmo = 1;
var spearSpeed = 0.2 / attack_speed;
var spearLevel = 1;

var tornadoAmmo = 0;
var tornadoBaseAmmo = 2;
var tornadoSpeed = 0.8 / attack_speed;
var tornadoLevel = 0;

var mamaAmmo = 0;
var mamaBaseAmmo = 1;
var mamaSpeed = 0.1 / attack_speed;
var mamaLevel = 0;

var enemyClose = [];

func _ready():
	attack();
	_check_level();

func attack():
	if spearLevel > 0:
		spearTimer.wait_time = spearSpeed;
		if spearTimer.is_stopped():
			spearTimer.start();
	if tornadoLevel > 0:
		tornadoTimer.wait_time = tornadoSpeed
		if tornadoTimer.is_stopped():
			tornadoTimer.start();
	if mamaLevel > 0:
		mamaTimer.wait_time = mamaSpeed
		if mamaTimer.is_stopped():
			mamaTimer.start();

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
		emit_signal("level", [spearLevel, tornadoLevel, mamaLevel]);

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

var tricksS = 0;

func _on_spearTimer_timeout():
	if tricksS == 6:
		spearAmmo += spearBaseAmmo;
		tricksS = 0;
	tricksS += 1;
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
		j+=1;

var tricksT = 0;

func _on_tornadoTimer_timeout():
	if tricksT == 4:
		tornadoAmmo += tornadoBaseAmmo;
		tricksT = 0;
	tricksT += 1;
	tornadoAttackTimer.start();


func _on_tornadoAttackTimer_timeout():
	if tornadoAmmo > 0:
		var tornadoAttack = tornado.instance();
		tornadoAttack.position = Vector2();
		if enemyClose.size() == 0:
			return;
		tornadoAttack.target = find_closest_node_to_point(enemyClose, global_position);
		tornadoAttack.base_pos = global_position;
		tornadoAttack.level = tornadoLevel;
		add_child(tornadoAttack);
		tornadoAmmo -= 1;
		if tornadoAmmo > 0:
			tornadoAttackTimer.start();
		else:
			tornadoAttackTimer.stop();

func _check_level():
	if spearLevel > 0:
		weapons.push_back("spear");
	if tornadoLevel > 0:
		weapons.push_back("tornado");
	if mamaLevel > 0:
		weapons.push_back("mama");
	emit_signal("weapons", weapons);

var tricks = 0;

func _on_mamaTimer_timeout():
	if tricks == 8:
		mamaAmmo += mamaBaseAmmo;
		tricks = 0;
	tricks += 1;
	mamaAttackTimer.start();


func _on_mamaAttackTimer_timeout():
	if mamaAmmo > 0:
		var mamaAttack = mama.instance();
		mamaAttack.position = Vector2();
		if enemyClose.size() == 0:
			return;
		mamaAttack.target = find_closest_node_to_point(enemyClose, global_position);
		mamaAttack.level = mamaLevel;
		add_child(mamaAttack);
		mamaAmmo -= 1;
		if mamaAmmo > 0:
			mamaAttackTimer.start();
		else:
			mamaAttackTimer.stop();

func _on_levelUp_spearLvlUp(value):
	spearLevel = value;

func _on_levelUp_axeLvlUp(value):
	tornadoBaseAmmo += 1;
	tornadoLevel = value;
	if tornadoLevel == 1:
		attack();
		_check_level();
	
func _on_levelUp_daggerLvlUp(value):
	mamaLevel = value;
	if mamaLevel == 1:
		attack();
		_check_level();
