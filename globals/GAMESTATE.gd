extends Node

signal update_map_unlocks

signal player_interact(held_item: String)

var player_active: bool = false

var map_unlocks: Dictionary[GAMEDATA.MAP_UNLOCKS, bool] = {
	GAMEDATA.MAP_UNLOCKS.GardenKey: false,
	GAMEDATA.MAP_UNLOCKS.DiningRoomKey: false,
	GAMEDATA.MAP_UNLOCKS.KitchenKey: false,
	GAMEDATA.MAP_UNLOCKS.PoolAreaKey: false,
	GAMEDATA.MAP_UNLOCKS.SaunaKey: false,
	GAMEDATA.MAP_UNLOCKS.StoreroomKey: false,
	GAMEDATA.MAP_UNLOCKS.LaundryKey: false,
	GAMEDATA.MAP_UNLOCKS.MechanicalRoomKey: false,
	GAMEDATA.MAP_UNLOCKS.ElevatorPass: false,
	GAMEDATA.MAP_UNLOCKS.StaircasePass: false,
	GAMEDATA.MAP_UNLOCKS.GuestRoomA1Key: false,
	GAMEDATA.MAP_UNLOCKS.GuestRoomB3Key: false,
	GAMEDATA.MAP_UNLOCKS.GuestRoomC2Key: false
}

func when_obtained_item(item: NetworkItem) -> void:
	var item_name = GAMEDATA.ITEM_ID_TO_NAME[item.id]
	var item_group = GAMEDATA.ITEM_GROUP.get(item_name)
	
	
	match item_group:
		"Map Access":
			if GAMEDATA.MAP_UNLOCKS_NAME_TO_ENUM.get(item_name) != null:
				map_unlocks.set(GAMEDATA.MAP_UNLOCKS_NAME_TO_ENUM[item_name], true)
				emit_signal("update_map_unlocks")
		_:
			pass
	
	print("[OBTAINED ITEM]: " + str(item))
