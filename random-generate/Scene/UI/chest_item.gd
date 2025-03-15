extends VBoxContainer
class_name ChestItem

const ITEMVISUAL = preload("res://Scene/UI/item_visual.tscn")

@export var item: Item : set = set_item

@onready var item_label: Label = %ItemLabel
@onready var item_container: CenterContainer = %ItemContainer

func set_item(new_item: Item) -> void:
	if not is_node_ready():
		await ready
	
	item = new_item
	
	item_label.text = str(item.name)
	
	for i in item_container.get_children():
		i.queue_free()
	
	var new_item_visual := ITEMVISUAL.instantiate() as ItemVisual
	item_container.add_child(new_item_visual)
	new_item_visual.item = item
	
