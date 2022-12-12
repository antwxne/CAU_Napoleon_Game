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

func _ready():
	angle = global_position.direction_to(target);
	$SpearSprite.rotation = angle.angle();
	match level:
		1:
			hp = 1
			speed = 250
			damage = 7
			knockback_amount = 140
			attack_size = 1.0 * (1 + oz)
		2:
			hp = 2
			speed = 260
			damage = 12
			knockback_amount = 160
			attack_size = 1.0 * (1 + oz)
		3:
			hp = 3
			speed = 275
			damage = 17
			knockback_amount = 180
			attack_size = 1.0 * (1 + oz)
		4:
			hp = 5
			speed = 280
			damage = 20
			knockback_amount = 200
			attack_size = 1.0 * (1 + oz)
	
	var tween = create_tween();
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT);
	tween.play();

func _physics_process(delta):
	position += angle*speed*delta;

func _on_Timer_timeout():
	queue_free();

func _on_Spear_body_entered(body):
	if body.name != "Player" && body.name != "Axe" && body.name != "Dagger":
		body.hp -= damage;
		body.dmg.emitting = true;
		body.knockback = angle * knockback_amount;
		damage =  5;
		hp -= 1;
		if hp <= 0:
			queue_free();
