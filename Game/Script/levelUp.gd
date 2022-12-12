extends Control

signal spearLvlUp(value);
signal axeLvlUp(value);
signal daggerLvlUp(value);

var spearLvl = 1;
var axeLvl = 0;
var daggerLvl = 0;

func _on_Player_level(value):
	visible = true;
	$GridContainer2/UpgradeSpear.grab_focus();
	get_tree().paused = true;
	spearLvl = value[0];
	axeLvl = value[1];
	daggerLvl = value[2];
	$GridContainer2/Spear.text = "Spear level: " + str(spearLvl);
	$GridContainer2/Axe.text = "Axe level: " + str(axeLvl);
	$GridContainer2/mama.text = "Dagger level: " + str(daggerLvl);
	$lvlUPMusique.play()

func _on_UpgradeSpear_pressed():
	get_tree().paused = false;
	visible = false;
	emit_signal("spearLvlUp", spearLvl + 1);

func _on_UpgradeAxe_pressed():
	get_tree().paused = false;
	visible = false;
	emit_signal("axeLvlUp", axeLvl + 1);

func _on_UpgradeMama_pressed():
	get_tree().paused = false;
	visible = false;
	emit_signal("daggerLvlUp", daggerLvl + 1);

func _on_Skip_pressed():
	visible = false;
	get_tree().paused = false;
