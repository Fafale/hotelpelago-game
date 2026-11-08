extends Node

signal update_map_unlocks

signal player_interact(held_item: String)
signal player_enter_door

signal request_map_change(destination: String, player_position: Vector2)

var player_active: bool = false
var player_control: bool = true

var preload_lobby = preload("res://maps/Lobby.tscn")
var preload_garden = preload("res://maps/Garden.tscn")
var preload_pool_area = preload("res://maps/PoolArea.tscn")

var received_inv_items: Dictionary[String, bool] = {
	'Food Trolley': false,
	'Water Can': false,
	'Gardening Gloves': false,
	'Gardening Boots': false,
	'Pruning Shears': false,
	'Swim Rings': false,
	'Wet Floor Sign': false,
	'Drink Tray': false,
	'Towels': false,
	'Mop & Bucket': false,
	'Toolkit': false,
	'Forklift': false,
	'Trash Bag': false,
	'Luggage Cart': false,
	'Pipe Wrench': false,
	'Laundry Basket': false,
	'Soap Bar': false
}

var inventory: Array[String] = ['None']
var held_item_index: int = 0

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
		"Storeroom Items", "Garden Items", "Kitchen Items", "Lobby Items", "Laundry Items", "Sauna Items", "Pool Area Items", "Mechanical Room Items":
			receive_new_item(item_name)
		_:
			pass
	
	print("[OBTAINED ITEM]: " + str(item))

func receive_new_item(item_name: String):
	received_inv_items[item_name] = true
	
	var aux_index = held_item_index
	held_item_index = 0
	inventory = ['None']
	for item in received_inv_items.keys():
		if received_inv_items[item]: inventory.append(item)
	held_item_index = aux_index

func get_map_node(map_name: String):
	match map_name:
		"Garden": return preload_garden
		"Pool Area": return preload_pool_area
		_: return preload_lobby

func get_held_item() -> String:
	return inventory[held_item_index]
