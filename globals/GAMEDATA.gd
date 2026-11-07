extends Node

var ITEM_ID_TO_NAME: Dictionary[int, String] = {
	1: 'Dining Room Key',
	2: 'Storeroom Key',
	3: 'Laundry Key',
	4: 'Elevator Pass',
	5: 'Staircase Pass',
	6: 'Garden Key',
	7: 'Pool Area Key',
	8: 'Kitchen Key',
	9: 'Sauna Key',
	10: 'Mechanical Room Key',
	11: 'Room A1 Key',
	12: 'Room B3 Key',
	13: 'Room C2 Key',
	14: 'Food Trolley',
	15: 'Water Can',
	16: 'Gardening Gloves',
	17: 'Gardening Boots',
	18: 'Pruning Shears',
	19: 'Recipe 1',
	20: 'Recipe 2',
	21: 'Recipe 3',
	22: 'Recipe 4',
	23: 'Recipe 5',
	24: 'Swim Rings',
	25: 'Wet Floor Sign',
	26: 'Drink Tray',
	27: 'Towels',
	28: 'Mop & Bucket',
	29: 'Toolkit',
	30: 'Forklift',
	31: 'Trash Bag',
	32: 'Luggage Cart',
	33: 'Pipe Wrench',
	34: 'Laundry Basket',
	35: 'Soap Bar',
	36: 'Filler',
}

var ITEM_GROUP = {
	'Dining Room Key': 'Map Access',
	'Storeroom Key': 'Map Access',
	'Laundry Key': 'Map Access',
	'Elevator Pass': 'Map Access',
	'Staircase Pass': 'Map Access',
	'Garden Key': 'Map Access',
	'Pool Area Key': 'Map Access',
	'Kitchen Key': 'Map Access',
	'Sauna Key': 'Map Access',
	'Mechanical Room Key': 'Map Access',
	'Room A1 Key': 'Map Access',
	'Room B3 Key': 'Map Access',
	'Room C2 Key': 'Map Access',
	
	'Food Trolley': 'Kitchen Items',
	
	'Water Can': 'Garden Items',
	'Gardening Gloves': 'Garden Items',
	'Gardening Boots': 'Garden Items',
	'Pruning Shears': 'Garden Items',
	
	'Recipe 1': 'Food Recipes',
	'Recipe 2': 'Food Recipes',
	'Recipe 3': 'Food Recipes',
	'Recipe 4': 'Food Recipes',
	'Recipe 5': 'Food Recipes',
	
	'Swim Rings': 'Pool Area Items',
	'Wet Floor Sign': 'Pool Area Items',
	'Drink Tray': 'Pool Area Items',
	
	'Towels': 'Sauna Items',
	
	'Mop & Bucket': 'Storeroom Items',
	'Toolkit': 'Storeroom Items',
	'Forklift': 'Storeroom Items',
	'Trash Bag': 'Storeroom Items',
	
	'Luggage Cart': 'Lobby Items',
	
	'Pipe Wrench': 'Mechanical Room Items',
	
	'Laundry Basket': 'Laundry Items',
	'Soap Bar': 'Laundry Items',
}

enum MAP_UNLOCKS {
	GardenKey,
	DiningRoomKey,
	KitchenKey,
	PoolAreaKey,
	SaunaKey,
	StoreroomKey,
	LaundryKey,
	MechanicalRoomKey,
	ElevatorPass,
	StaircasePass,
	GuestRoomA1Key,
	GuestRoomB3Key,
	GuestRoomC2Key,
	NONE
}

var MAP_UNLOCKS_NAME_TO_ENUM = {
	'Dining Room Key': MAP_UNLOCKS.DiningRoomKey,
	'Storeroom Key': MAP_UNLOCKS.StoreroomKey,
	'Laundry Key': MAP_UNLOCKS.LaundryKey,
	'Elevator Pass': MAP_UNLOCKS.ElevatorPass,
	'Staircase Pass': MAP_UNLOCKS.StaircasePass,
	'Garden Key': MAP_UNLOCKS.GardenKey,
	'Pool Area Key': MAP_UNLOCKS.PoolAreaKey,
	'Kitchen Key': MAP_UNLOCKS.KitchenKey,
	'Sauna Key': MAP_UNLOCKS.SaunaKey,
	'Mechanical Room Key': MAP_UNLOCKS.MechanicalRoomKey,
	'Room A1 Key': MAP_UNLOCKS.GuestRoomA1Key,
	'Room B3 Key': MAP_UNLOCKS.GuestRoomB3Key,
	'Room C2 Key': MAP_UNLOCKS.GuestRoomC2Key
}
