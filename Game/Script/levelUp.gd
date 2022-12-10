extends Control

func _on_Player_level(value):
	visible = true;
	$GridContainer2/UpgradeSpear.grab_focus();
	get_tree().paused = true;

func _on_UpgradeSpear_pressed():
	pass # Replace with function body.

func _on_UpgradeAxe_pressed():
	pass # Replace with function body.

func _on_Upgrade_pressed():
	pass # Replace with function body.

func _on_Skip_pressed():
	visible = false;
	get_tree().paused = false;
