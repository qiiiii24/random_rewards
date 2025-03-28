extends Area2D
class_name Interactable

signal interacted

func _init() -> void:
	collision_layer = 0
	collision_mask = 0
	
	set_collision_mask_value(2, true)
	
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

func interact() -> void:
	#print("[Interact %s]" % name)
	interacted.emit()

func _body_entered(player: Player) -> void:
	player.register_interactable(self)

func _body_exited(player: Player) -> void:
	player.unregister_interactable(self)
