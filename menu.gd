extends Control

@onready var node_commonclient: Node = $CanvasLayer/CommonClient
@onready var node_gamecontroller: Node = $GameController

@onready var node_screenfade: TextureRect = $CanvasLayer/FadeBlack

const STARTING_MAP = "Lobby"
const STARTING_POS = Vector2(611, 308)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Archipelago.load_console(node_commonclient, false)
	
	Archipelago.roominfo.connect(when_roominfo)
	Archipelago.disconnected.connect(when_disconnected)
	
	GAMESTATE.request_map_change.connect(when_request_map_change)

func _process(_delta: float) -> void:
	if GAMESTATE.player_active and Input.is_action_just_pressed("toggle_console"):
		node_commonclient.visible = not node_commonclient.visible

func when_roominfo(conn, _json):
	conn.obtained_item.connect(GAMESTATE.when_obtained_item)
	conn.obtained_items.connect(when_obtained_items)
	conn.refresh_items.connect(when_refresh_items)
	
	GAMESTATE.player_active = true
	node_gamecontroller.show()
	
	when_request_map_change(STARTING_MAP, STARTING_POS)

func when_disconnected():
	GAMESTATE.player_active = false
	node_commonclient.show()

func when_obtained_items(items: Array[NetworkItem]):
	print("[OBTAINED ITEMS]: " + str(items))

func when_refresh_items(all_items: Array[NetworkItem]):
	print("[REFRESH ITEMS]: " + str(all_items))

func when_request_map_change(new_map: String, player_position: Vector2) -> void:
	screen_fade_black(change_map.bind(new_map, player_position))

func change_map(new_map: String, player_position: Vector2) -> void:
	if node_gamecontroller.get_child_count() > 0:
		var cur_map = node_gamecontroller.get_child(0)
		cur_map.queue_free()
	
	var map_inst = GAMESTATE.get_map_node(new_map).instantiate()
	node_gamecontroller.add_child(map_inst)
	var player_node: Node2D = map_inst.find_child("Player")
	player_node.global_position = player_position

func screen_fade_black(method: Callable) -> void:
	node_screenfade.self_modulate.a = 0.0
	node_screenfade.show()
	GAMESTATE.player_control = false
	
	var tween = get_tree().create_tween()
	tween.tween_property(node_screenfade, "self_modulate:a", 1.0, 0.5)
	tween.tween_callback(method)
	tween.tween_property(node_screenfade, "self_modulate:a", 0.0, 0.5)
	tween.tween_callback(node_screenfade.hide)
	tween.tween_callback(GAMESTATE.set.bind('player_control', true))
