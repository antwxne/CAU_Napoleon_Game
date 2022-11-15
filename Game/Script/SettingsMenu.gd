extends Control

onready var videoMode = $TabContainer/Video/GridContainer/VideoMode
onready var checkVsync = $TabContainer/Video/GridContainer/CheckVsync
onready var checkFps = $TabContainer/Video/GridContainer/CheckFps
onready var sliderFps = $TabContainer/Gameplay/GridContainer/HBoxContainer/SliderFps
onready var sliderB = $TabContainer/Video/GridContainer/SliderB

onready var sliderMaster = $TabContainer/Audio/GridContainer/SliderMaster
onready var sliderMusic = $TabContainer/Audio/GridContainer/SliderMusic
onready var sliderSfx = $TabContainer/Audio/GridContainer/SliderSFX

onready var sliderSpeed = $TabContainer/Gameplay/GridContainer/HBoxContainer/SliderSpeed

func _ready():
	$TabContainer/Video/GridContainer/VideoMode.grab_focus();

func _on_Return_pressed():
	get_tree().change_scene("res://Menu.tscn");


func _on_VideoMode_item_selected(index):
	pass # Replace with function body. 


func _on_CheckVsync_toggled(button_pressed):
	pass # Replace with function body.


func _on_CheckFps_toggled(button_pressed):
	pass # Replace with function body.


func _on_SliderFps_drag_ended(value_changed):
	pass # Replace with function body.



func _on_SliderMaster_drag_ended(value_changed):
	pass # Replace with function body.


func _on_SliderMusic_drag_ended(value_changed):
	pass # Replace with function body.


func _on_SliderSFX_drag_ended(value_changed):
	pass # Replace with function body.


func _on_SliderSpeed_drag_ended(value_changed):
	pass # Replace with function body.
