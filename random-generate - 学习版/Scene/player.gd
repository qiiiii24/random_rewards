class_name Player
extends CharacterBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var graphics: Node2D = $Graphics
@onready var interact_anim: AnimatedSprite2D = $InteractAnim

@export var run_speed : float = 50

var gravity := ProjectSettings.get("physics/2d/default_gravity") as float

var facingDir := 1
var facingRight := true

var is_attacking := false

var interacting_with : Array[Interactable]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		animation_player.play("Attack")
		is_attacking = true
	if event.is_action_pressed("interact") and interacting_with:
		interacting_with.back().interact()


func _physics_process(delta: float) -> void:
	interact_anim.visible = not interacting_with.is_empty()
	velocity.y += gravity * delta
	
	animation_controller()
	move_controller()

func register_interactable(v: Interactable) -> void:
	if v in interacting_with:
		return
	interacting_with.append(v)

func unregister_interactable(v: Interactable) -> void:
	interacting_with.erase(v)

func move_controller() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0 and !facingRight:
		flip()
	elif direction < 0 and facingRight:
		flip()

	velocity.x = direction * run_speed
	
	move_and_slide()

func attack_end() -> void:
	animation_player.play("Idle")
	is_attacking = false

func animation_controller() -> void:
	if is_attacking : return
	
	if velocity.x == 0:
		animation_player.play("Idle")
	elif velocity.x != 0:
		animation_player.play("Run")
	
	

func flip() -> void:
	facingDir *= -1
	facingRight = !facingRight
	graphics.scale.x = facingDir
	
	
