extends Area2D

var level = 1;
var hp = 1;
var speed = 250;
var damage = 5;
var knockback_amount = 100;
var attack_size = 1.0;
var oz = Save.gameData.player.offense_zone;

var target = Vector2.ZERO;
var angle = Vector2.ZERO;

signal remove_from_array(object);

func _ready():
	angle = global_position.direction_to(target);
	$SpearSprite.rotation = angle.angle();
	match level:
		1:
			hp = 1
			speed = 250
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
		2:
			hp = 1
			speed = 250
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
		3:
			hp = 2
			speed = 250
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
		4:
			hp = 1
			speed = 250
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + oz)
	
	var tween = create_tween();
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT);
	tween.play();

func _physics_process(delta):
	position += angle*speed*delta;

func _on_Timer_timeout():
	emit_signal("remove_from_array",self);
	queue_free();

func _on_Spear_body_entered(body):
	if body.name != "Player":
		body.hp -= damage;
		damage =  5;
		print("Spear hp:" + str(body.hp));
		hp -= 1;
		if hp <= 0:
			emit_signal("remove_from_array",self);
			queue_free();
