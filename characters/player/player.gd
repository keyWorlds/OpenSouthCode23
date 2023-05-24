extends CharacterBody2D

@export var walkSpeed = 4.0
const TILESIZE = 16

@onready var animPlayer = $AnimationPlayer

var initialPosition = Vector2(0, 0)
var inputDirection = Vector2(0, 0)
var isMoving = false
var percentMovedToNextTile = 0.0

func _ready():
	initialPosition = position

func _physics_process(delta):
	if isMoving == false:
		process_player_input()
	elif inputDirection != Vector2.ZERO:
		move(delta)
	else:
		isMoving = false

func process_player_input():
	if inputDirection.y == 0:
		inputDirection.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if inputDirection.x == 0:
		inputDirection.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if inputDirection != Vector2.ZERO:
		initialPosition = position
		isMoving = true
	
	playAnims(inputDirection)

func move(delta):
	percentMovedToNextTile += walkSpeed * delta
	if percentMovedToNextTile >= 1:
		position = initialPosition + (TILESIZE * inputDirection)
		percentMovedToNextTile = 0
		isMoving = false
	else:
		position = initialPosition + (TILESIZE * inputDirection * percentMovedToNextTile)

func playAnims(inputDirection):
	if inputDirection == Vector2.ZERO:
		animPlayer.play("idle_down")
	else:
		if inputDirection.x > 0: animPlayer.play("walk_right")
		elif inputDirection.x < 0: animPlayer.play("walk_left")
		elif inputDirection.y > 0: animPlayer.play("walk_down")
		elif inputDirection.y < 0: animPlayer.play("walk_up")
