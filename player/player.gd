extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

const SPEED = 300.0

var input = Vector2.ZERO

func _process(_delta: float) -> void:
	if input.y > 0:
		sprite.region_rect.position.x = 0
	elif input.y < 0:
		sprite.region_rect.position.x = 64
	elif input.x > 0:
		sprite.flip_h = false
		sprite.region_rect.position.x = 32
	elif input.x < 0:
		sprite.flip_h = true
		sprite.region_rect.position.x = 32

func _physics_process(_delta: float) -> void:
	if GAMESTATE.player_active:
		input.x = Input.get_axis("move_left", "move_right")
		input.y = Input.get_axis("move_up", "move_down")
		
		input = input.normalized()
		velocity = input * SPEED
		move_and_slide()
