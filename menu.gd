extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Archipelago.load_console($CommonClient, false)
	
	Archipelago.roominfo.connect(when_roominfo)

func when_roominfo(conn, _json):
	conn.obtained_item.connect(when_obtained_item)
	conn.obtained_items.connect(when_obtained_items)
	conn.refresh_items.connect(when_refresh_items)

func when_obtained_item(item: NetworkItem):
	print("[OBTAINED ITEM]: " + str(item))

func when_obtained_items(items: Array[NetworkItem]):
	print("[OBTAINED ITEMS]: " + str(items))

func when_refresh_items(all_items: Array[NetworkItem]):
	print("[REFRESH ITEMS]: " + str(all_items))
