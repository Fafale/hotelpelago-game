extends Area2D

@export var related_unlock: GAMEDATA.MAP_UNLOCKS
@export var dest_map: String = ""
@export var dest_pos: Vector2 = Vector2.ZERO

@onready var lock_sprite: Sprite2D = $Lock_Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if related_unlock != GAMEDATA.MAP_UNLOCKS.NONE:
		update_lock()
		GAMESTATE.update_map_unlocks.connect(update_lock)
	
	GAMESTATE.player_enter_door.connect(when_player_enter_door)

func update_lock() -> void:
	lock_sprite.visible = not GAMESTATE.map_unlocks[related_unlock]

func when_player_enter_door() -> void:
	if not lock_sprite.visible:
		if has_overlapping_bodies():
			if get_overlapping_bodies()[0].is_in_group("Player"):
				GAMESTATE.emit_signal("request_map_change", dest_map, dest_pos)
