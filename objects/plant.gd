extends Area2D

@onready var event_node: Node2D = get_parent()
@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	GAMESTATE.player_interact.connect(when_player_interacted)

func when_player_interacted(held_item: String):
	if held_item == "Pruning Shears":
		if has_overlapping_bodies():
			if get_overlapping_bodies()[0].is_in_group("Player"):
				prune_plant()

func prune_plant() -> void:
	sprite.region_rect.position.x = 32
	event_node.emit_signal("child_plant_pruned")
	GAMESTATE.player_interact.disconnect(when_player_interacted)
