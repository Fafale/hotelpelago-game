extends Node2D

signal child_plant_pruned

@onready var total_plant_count: int = get_child_count()
var pruned_plants: int = 0

@export var related_location_id: int = -1

func _ready() -> void:
	child_plant_pruned.connect(when_child_plant_pruned)
	
	if Archipelago.location_checked(related_location_id, false):
		for child in get_children():
			child.set_pruned()

func when_child_plant_pruned() -> void:
	pruned_plants += 1
	
	if pruned_plants == total_plant_count:
		Archipelago.collect_location(related_location_id)
