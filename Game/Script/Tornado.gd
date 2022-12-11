extends Area2D

var level = 1;
var hp = 1;
var speed = 250;
var damage = 5;
var knockback_amount = 100;
var attack_size = 1.0;
var oz = Save.gameData.player.offense_zone / 2;

var target = Vector2.ZERO;
var base_pos = Vector2.ZERO;
var angle = Vector2.ZERO;
var rota = 0;

signal remove_from_array(object);

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize();
	target.x = rng.randi_range(-1, 1);
	target.y = rng.randi_range(-1, 1);
	if target.x == 0 && target.y == 0:
		target.x = -1;
	angle = target;
	$TornadoSprite.rotation = angle.angle();
	rota = angle.angle();
	match level:
		1:
			hp = 9999
			speed = 375
			damage = 3
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
		2:
			hp = 9999
			speed = 400
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
		3:
			hp = 9999
			speed = 425
			damage = 10
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
		4:
			hp = 9999
			speed = 450
			damage = 15
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
	
	var tween = create_tween();
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT);
	tween.play();

func _physics_process(delta):
	rota += 0.25;
	if int(rota) > 360:
		rota = 0;
	$TornadoSprite.rotation = int(rota);
	position += angle*speed*delta;

func _on_Timer_timeout():
	emit_signal("remove_from_array",self);
	queue_free();

func _on_Tornado_body_entered(body):
	if body.name != "Player":
		body.hp -= damage;
		body.dmg.emitting = true;
		damage =  5;
		hp -= 1;
		if hp <= 0:
			emit_signal("remove_from_array",self);
			queue_free();
