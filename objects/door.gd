extends Area2D

@export var related_unlock: GAMEDATA.MAP_UNLOCKS

@onready var lock_sprite: Sprite2D = $Lock_Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if related_unlock != GAMEDATA.MAP_UNLOCKS.NONE:
		update_lock()
		GAMESTATE.connect("update_map_unlocks", update_lock)

func update_lock() -> void:
	lock_sprite.visible = not GAMESTATE.map_unlocks[related_unlock]
