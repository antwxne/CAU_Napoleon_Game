extends KinematicBody2D

export (int) var speed = 200

onready var _animated_sprite = $AnimatedSprite

export var velocity = Vector2()

export var mouse_sensitivity = .1;

func _ready():
	GlobalSettings.connect("mouse_sens", self, "_on_mouse_sens");

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("Down"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = 0;
		$ParticuleMove.direction.y = -1;
		velocity.y += 1
		_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Right"):
			$ParticuleMove.direction.x = -1;
			velocity.x += 1
			_animated_sprite.play("down_direction")
		if Input.is_action_pressed("Left"):
			$ParticuleMove.direction.x = 1;
			velocity.x -= 1
			_animated_sprite.play("down_direction")
	elif Input.is_action_pressed("Up"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = 0;
		$ParticuleMove.direction.y = 1;
		velocity.y -= 1
		_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Right"):
			$ParticuleMove.direction.x = -1;
			velocity.x += 1
			_animated_sprite.play("up_direction")
		if Input.is_action_pressed("Left"):
			$ParticuleMove.direction.x = 1;
			velocity.x -= 1
			_animated_sprite.play("up_direction")
	elif Input.is_action_pressed("Left"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = 1;
		$ParticuleMove.direction.y = 0;
		velocity.x -= 1
		_animated_sprite.play("left_direction")
	elif Input.is_action_pressed("Right"):
		$ParticuleMove.emitting = true;
		$ParticuleMove.direction.x = -1;
		$ParticuleMove.direction.y = 0;
		velocity.x += 1
		_animated_sprite.play("right_direction")
	else:
		$ParticuleMove.emitting = false;
		_animated_sprite.play("idle")

	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_mouse_sens(value):
	mouse_sensitivity = value;
