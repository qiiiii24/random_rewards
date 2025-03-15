extends Node

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE
}

var item_rarity_weight := {
	Rarity.COMMON : 0.0,
	Rarity.UNCOMMON : 0.0,
	Rarity.RARE : 0.0
}

const COMMON := 30.0  # 普通
const UNCOMMON :=  20.0      # 不常见
const RARE := 10.0           # 稀有

var total_weigth : float
var luck = Attributes.luck
var item_amount = Attributes.item_amount

var available_item: Array[Item]

func setup_item_weight() -> void:
	item_rarity_weight[Rarity.COMMON] = COMMON + luck
	item_rarity_weight[Rarity.UNCOMMON] = item_rarity_weight[Rarity.COMMON] + UNCOMMON + luck
	item_rarity_weight[Rarity.RARE] = item_rarity_weight[Rarity.UNCOMMON] + RARE + luck
	total_weigth = item_rarity_weight[Rarity.RARE]

# 会返回数量为item_amount的Array[Item]
func get_random_items(new_item_array: Array[Item]) -> Array[Item]:
	var shop_item_array : Array[Item] = []
	if  not new_item_array : return shop_item_array
	
	available_item= new_item_array
	
	for i in range(item_amount):
		setup_item_weight()
		var roll = randf_range(0, total_weigth)
		
		for rarity: Rarity in item_rarity_weight:
			if item_rarity_weight[rarity] > roll:
				var picked_item := get_rondom_available_items(available_item, rarity)
				shop_item_array.append(picked_item)
				break
	return shop_item_array

func get_rondom_available_items(item_array: Array[Item], rarity: Rarity) -> Item:
	var available_items: Array[Item] = []
	
	for item: Item in item_array:
		if item.rarity == rarity:
			available_items.append(item)
	available_items.shuffle()
	
	return available_items[0]
