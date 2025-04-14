extends Node2D

@export var state: bool

@onready var sprite = $AnimatedSprite2D
@onready var interactable = $SwitchInteractable

func _ready() -> void:
	interactable.state = state

func _on_switch_interactable_switch_flipped(switch_flag: String, switch_state: bool) -> void:
	if switch_state:
		sprite.play()
	else:
		sprite.play_backwards()
