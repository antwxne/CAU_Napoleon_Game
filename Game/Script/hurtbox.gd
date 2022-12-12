extends Area2D

enum hurtbox {Cooldown,HitOnce,DisableHurtBox}
export(hurtbox) var HurtBoxType = hurtbox.Cooldown

onready var collision = $CollisionShape2D
onready var disableTimer = $Timer
signal hurt(damage, angle, knockback)
var hit_once_array = []


func remove_from_list(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)

func _on_hurtbox_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #Cooldown
					collision.call_deferred("set","disabled",true)
					disableTimer.start()
				1: #HitOnce
					if hit_once_array.has(area) == false:
						hit_once_array.append(area)
				2: #DisableHurtBox
					if area.has_method("tempdisable"):
						area.tempdisable()
					
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)
				
			emit_signal("hurt",damage, angle, knockback);

func _on_Timer_timeout():
	collision.call_deferred("set","disabled",false)
