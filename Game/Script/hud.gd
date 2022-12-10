extends Control

var gold = Save.gameData.player.gold;
var time = 0;
var health = 50 + Save.gameData.player.health * 10;
var base_health = 50 + Save.gameData.player.health * 10;
var xp = 0;
var max_xp = 50;

var spear_sprite = preload("res://Sprite/Spear.png");
var tornado_sprite = preload("res://Sprite/tornado.png");

func _ready():
	update();
	
func update():
	$CanvasLayer/VBoxContainer/Label2.text = "Gold: " + str(gold);

func _process(delta):
	time += delta;
	var mils = fmod(time, 1) * 1000;
	var sec = fmod(time, 60);
	var mins = fmod(time, 60 * 60) / 60;
	$CanvasLayer/VBoxContainer/Label.text = "%02d : %02d : %03d" % [mins, sec, mils];

func _on_hurtbox_hurt(damage, _angle, _knockback):
	health -= damage;
	$CanvasLayer/VBoxContainer/health.value = (health * 100 / base_health);

func _on_Player_xp(value):
	xp += value;
	if xp >= max_xp:
		xp -= max_xp;
		max_xp += 10;
	$CanvasLayer/VBoxContainer/xp.value = (xp * 100 / max_xp);

func _on_Player_gold(value):
	gold = Save.gameData.player.gold;
	$CanvasLayer/VBoxContainer/Label2.text = "Gold: " + str(gold);

var hud_first = false;

func _on_Player_weapons(value):
	for i in value:
		if i == "spear" && !hud_first:
			$CanvasLayer/GridContainer/ItemContainer/TextureRect.set_texture(spear_sprite);
			hud_first = true;
		elif i == "tornado" && !hud_first:
			$CanvasLayer/GridContainer/ItemContainer/TextureRect.set_texture(tornado_sprite);
			hud_first = true;
		else:
			$CanvasLayer/GridContainer/ItemContainer2/TextureRect.set_texture(spear_sprite);
