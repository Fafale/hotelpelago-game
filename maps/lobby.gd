extends Node2D

@onready var event_

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Archipelago.roominfo.connect(when_connection_exists)

func when_connection_exists(_conn, _json):
	
	pass
