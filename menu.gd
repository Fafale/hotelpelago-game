extends Control

@onready var node_commonclient: Node = $CanvasLayer/CommonClient
@onready var node_gamecontroller: Node = $GameController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Archipelago.load_console(node_commonclient, false)
	
	Archipelago.roominfo.connect(when_roominfo)
	Archipelago.disconnected.connect(when_disconnected)

func _process(_delta: float) -> void:
	if GAMESTATE.player_active and Input.is_action_just_pressed("toggle_console"):
		node_commonclient.visible = not node_commonclient.visible

func when_roominfo(conn, _json):
	conn.obtained_item.connect(GAMESTATE.when_obtained_item)
	conn.obtained_items.connect(when_obtained_items)
	conn.refresh_items.connect(when_refresh_items)
	
	GAMESTATE.player_active = true
	node_gamecontroller.show()

func when_disconnected():
	GAMESTATE.player_active = false
	node_commonclient.show()

func when_obtained_items(items: Array[NetworkItem]):
	print("[OBTAINED ITEMS]: " + str(items))

func when_refresh_items(all_items: Array[NetworkItem]):
	print("[REFRESH ITEMS]: " + str(all_items))
