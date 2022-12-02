extends Area2D


export var damage = 1
onready var collision = $CollisionShape2D
onready var disableTimer = $Timer

func tempdisable():
	collision.call_deferred("set","disabled",true)
	if disableTimer.is_stopped():
		disableTimer.start()

func _on_Timer_timeout():
	collision.disabled = false
