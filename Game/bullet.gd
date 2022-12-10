extends Node2D

var direction = Vector2.RIGHT
var speed := 400.0

fun _ready():
	direciton = direction.normalized()
	
