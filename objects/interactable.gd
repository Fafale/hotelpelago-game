extends Area2D

@onready var event_node: Node2D = get_parent()
@onready var sprite: Sprite2D = $Sprite

@export var required_held_item: String = "None"
@export var completed_sprite_pos: int = -1

func _ready() -> void:
	GAMESTATE.player_interact.connect(when_player_interacted)

func when_player_interacted(held_item: String):
	if (held_item == required_held_item) or (required_held_item == "None"):
		if has_overlapping_bodies():
			if get_overlapping_bodies()[0].is_in_group("Player"):
				call_interacted()

func call_interacted() -> void:
	set_completed()
	event_node.emit_signal("child_interacted")

func set_completed() -> void:
	if completed_sprite_pos != -1:
		sprite.region_rect.position.x = completed_sprite_pos
	else:
		hide()
	
	if GAMESTATE.player_interact.is_connected(when_player_interacted):
		GAMESTATE.player_interact.disconnect(when_player_interacted)
