extends Control

var gold = Save.gameData.player.gold;
var time = 0;
var health = 100 + (Save.gameData.player.health * 10);
var baseHealth = 100 + Save.gameData.player.health * 10;

func _ready():
	update();
	
func update():
	print(Save.gameData.player.health);
	print(health);
	$CanvasLayer/VBoxContainer/Label2.text = "Gold: " + str(gold);

func _process(delta):
	time += delta;
	var mils = fmod(time, 1) * 1000;
	var sec = fmod(time, 60);
	var mins = fmod(time, 60 * 60) / 60;
	$CanvasLayer/VBoxContainer/Label.text = "%02d : %02d : %03d" % [mins, sec, mils];


func _on_hurtbox_hurt(damage, angle, knockback):
	health -= damage;
	$CanvasLayer/VBoxContainer/health.value = (health * 100 / baseHealth);

