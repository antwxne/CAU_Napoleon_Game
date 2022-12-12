extends Control

var gold = Save.gameData.player.gold;
var time = 0;
var health = 40 + Save.gameData.player.health * 10;
var base_health = 40 + Save.gameData.player.health * 10;
var armor = Save.gameData.player.armor * 2;
var xp = 0;
var max_xp = 30;

var spear_sprite = preload("res://Sprite/Spear.png");
var axe_sprite = preload("res://Sprite/axe.png");
var dagger_sprite = preload("res://Sprite/dagger.png");

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

func _on_Player_xp(value):
	xp += value;
	if xp >= max_xp:
		xp -= max_xp;
		max_xp += 20;
	$CanvasLayer/VBoxContainer/xp.value = (xp * 100 / max_xp);

func _on_Player_gold(_value):
	gold = Save.gameData.player.gold;
	$CanvasLayer/VBoxContainer/Label2.text = "Gold: " + str(gold);

func _on_Player_weapons(value):
	for i in value:
		if i == "spear":
			$CanvasLayer/GridContainer/ItemContainer/TextureRect.set_texture(spear_sprite);
		elif i == "axe":
			$CanvasLayer/GridContainer/ItemContainer2/TextureRect.set_texture(axe_sprite);
		elif i == "dagger":
			$CanvasLayer/GridContainer/ItemContainer3/TextureRect.set_texture(dagger_sprite);


func _on_Player_hp(value):
	health = value;
	$CanvasLayer/VBoxContainer/health.value = (health * 100 / base_health);
