extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

const SPEED = 300.0

@onready var interact_timer: Timer = $InteractTimer

var held_item: String = ''

var movement_input = Vector2.ZERO

func _process(_delta: float) -> void:
	if GAMESTATE.player_active and GAMESTATE.player_control:
		if movement_input.y > 0:
			sprite.region_rect.position.x = 0
		elif movement_input.y < 0:
			sprite.region_rect.position.x = 64
		elif movement_input.x > 0:
			sprite.flip_h = false
			sprite.region_rect.position.x = 32
		elif movement_input.x < 0:
			sprite.flip_h = true
			sprite.region_rect.position.x = 32
		
		if Input.is_action_just_pressed("interact") and interact_timer.time_left == 0.0:
			interact_timer.start(0.5)
			GAMESTATE.emit_signal("player_interact", held_item)
		elif Input.is_action_just_pressed("enter_door") and interact_timer.time_left == 0.0:
			interact_timer.start(0.5)
			GAMESTATE.emit_signal("player_enter_door")

func _physics_process(_delta: float) -> void:
	if GAMESTATE.player_active and GAMESTATE.player_control:
		movement_input.x = Input.get_axis("move_left", "move_right")
		movement_input.y = Input.get_axis("move_up", "move_down")
		
		movement_input = movement_input.normalized()
		velocity = movement_input * SPEED
		move_and_slide()
