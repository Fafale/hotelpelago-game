extends Area2D

const GUESTS_LOCATION_ID = [1,2,3]

@onready var sprite_guest1: Sprite2D = $Guest1
@onready var sprite_guest2: Sprite2D = $Guest2
@onready var sprite_guest3: Sprite2D = $Guest3

# Set to true when it's the Lobby loaded on game start (need delay to get server info)
var first_screen: bool = false

var unchecked_locations: Array[int] = []
var guest_count = 3

func _ready() -> void:
	prepare_event(null, null)

func prepare_event(_conn, _json) -> void:
	for id in GUESTS_LOCATION_ID:
		if Archipelago.location_checked(id) == true: guest_count -= 1
		else: unchecked_locations.append(id)
	
	update_visible_guests()
		
	GAMESTATE.player_interact.connect(when_player_interacted)


func update_visible_guests():
	if guest_count <= 2:
		sprite_guest3.hide()
	if guest_count <= 1:
		sprite_guest2.hide()
	if guest_count <= 0:
		sprite_guest1.hide()
		
		if GAMESTATE.is_connected("player_interact", when_player_interacted):
			GAMESTATE.disconnect("player_interact", when_player_interacted)
		
		hide()

func when_player_interacted(_held_item: String):
	if has_overlapping_bodies():
		if get_overlapping_bodies()[0].is_in_group("Player"):
			send_next_check()

func send_next_check():
	if not unchecked_locations.is_empty():
		Archipelago.collect_location(unchecked_locations.pop_front())
	
	guest_count -= 1
	update_visible_guests()
