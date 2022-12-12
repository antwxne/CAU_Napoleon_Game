extends Area2D

var level = 1;
var hp = 1;
var speed = 250;
var damage = 5;
var knockback_amount = 100;
var attack_size = 1.0;
var oz = Save.gameData.player.offense_zone / 2;

var target = Vector2.ZERO;
var angle = Vector2.ZERO;

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize();
	target.x = rng.randi_range(-1, 1);
	target.y = rng.randi_range(-1, 1);
	angle = target;
	$DaggerSprite.rotation = angle.angle();
	match level:
		1:
			hp = 1
			speed = 300
			damage = 3
			knockback_amount = 50
			attack_size = 1.0 * (1 + oz)
		2:
			hp = 1
			speed = 320
			damage = 5
			knockback_amount = 65
			attack_size = 1.0 * (1 + oz)
		3:
			hp = 1
			speed = 340
			damage = 7
			knockback_amount = 75
			attack_size = 1.0 * (1 + oz)
		4:
			hp = 1
			speed = 350
			damage = 10
			knockback_amount = 80
			attack_size = 1.0 * (1 + oz)
	
	var tween = create_tween();
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT);
	tween.play();

func _physics_process(delta):
	rng.randomize();
	angle.x = rng.randi_range(-1, 1);
	angle.y = rng.randi_range(-1, 1);
	position += angle*speed*delta;

func _on_Timer_timeout():
	queue_free();

func _on_Dagger_body_entered(body):
	if body.name != "Player" && body.name != "Spear" && body.name != "Axe":
		body.hp -= damage;
		body.dmg.emitting = true;
		damage =  5;
		body.knockback = angle * knockback_amount;
		hp -= 1;
		if hp <= 0:
			queue_free();
