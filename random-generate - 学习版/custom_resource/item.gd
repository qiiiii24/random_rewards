extends Resource
class_name Item

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE
}

@export_group("Item Visuals")
@export var icon : Texture
@export var name : String

@export_group("Item Attributes")
@export var rarity: Rarity
