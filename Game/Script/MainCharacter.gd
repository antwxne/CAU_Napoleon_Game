extends KinematicBody2D

export (int) var speed = 200

onready var _animated_sprite = $AnimatedSprite

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	
	
	if Input.is_action_pressed("Down"):
		velocity.y += 1
		_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Right"):
			 velocity.x += 1	
			 _animated_sprite.play("down_direction")
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
			_animated_sprite.play("down_direction")
	elif Input.is_action_pressed("Up"):
		velocity.y -= 1
		_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Right"):
			velocity.x += 1	
			_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
			_animated_sprite.play("up_direction")
	elif Input.is_action_pressed("Left"):
		velocity.x -= 1
		_animated_sprite.play("left_direction")
	elif Input.is_action_pressed("Right"):
		velocity.x += 1	
		_animated_sprite.play("right_direction")
	else:
		_animated_sprite.play("idle")
		
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
