extends Node2D

signal child_interacted

@onready var total_child_count: int = get_child_count()
var completed_children: int = 0

@export var related_location_id: int = -1

func _ready() -> void:
	if Archipelago.location_checked(related_location_id):
		for child in get_children():
			child.set_completed()
	else:
		child_interacted.connect(when_child_interacted)

func when_child_interacted() -> void:
	completed_children += 1
	
	if completed_children == total_child_count:
		Archipelago.collect_location(related_location_id)
