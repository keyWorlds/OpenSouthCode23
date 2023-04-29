extends CharacterBody2D

var speed = 200

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed * delta
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed * delta
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x += speed * delta
	else:
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
