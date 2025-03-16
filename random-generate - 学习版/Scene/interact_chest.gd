extends Interactable

@onready var chest_anim: AnimatedSprite2D = %ChestAnim

func _ready() -> void:
	interacted.connect(_play_anim)

func _play_anim() -> void:
	chest_anim.play("Open")
	
