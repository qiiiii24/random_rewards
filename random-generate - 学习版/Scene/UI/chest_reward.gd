extends Control
class_name ChestRewards

const CHEST_ITEM = preload("res://Scene/UI/chest_item.tscn")
const REWARD_AMOUNT := 3

@export var chest_rewards: Array[Item] : set = set_rewards

@onready var items: HBoxContainer = %Items
@onready var skip_button: Button = $SkipButton

func _ready() -> void:
	_clear_rewards()
	skip_button.pressed.connect(set_reward_visible)
	var chest = get_tree().get_first_node_in_group("Chest") as Interactable
	chest.interacted.connect(set_reward_visible)
	

func _clear_rewards() -> void:
	for item: Node in items.get_children():
		item.queue_free()

func set_rewards(new_rewards: Array[Item]) -> void:
	chest_rewards = new_rewards
	
	if not is_node_ready():
		await ready
	
	_clear_rewards()
	for i in range(REWARD_AMOUNT):
		chest_rewards.shuffle()
		var item: Item = chest_rewards[0]
		var new_item := CHEST_ITEM.instantiate() as ChestItem
		items.add_child(new_item)
		new_item.item = item


func set_reward_visible() -> void:
	visible = !visible
