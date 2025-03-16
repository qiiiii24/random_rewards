extends Control
class_name ItemVisual

@export var item: Item : set = set_item

@onready var icon: TextureRect = $Icon

func set_item(value: Item) -> void:
	if not is_node_ready():
		await ready
	
	item = value
	icon.texture = item.icon
