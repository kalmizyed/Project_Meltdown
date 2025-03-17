class_name SwitchInteractable
extends Interactable

signal switch_flipped(switch_flag: String, switch_state: bool)

## A flag to be sent with the switch flip signal so nodes that catch the signal know which switch
## node is being flipped.
@export var flag: String

## The current state of the switch after flipping.
@export var state: bool

func _ready() -> void:
	switch_flipped.connect(_on_switch_flipped)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and hitbox and hitbox.has_overlapping_bodies():
		state = !state
		switch_flipped.emit(flag, state)

func _on_switch_flipped(switch_flag: String, switch_state: bool) -> void:
	print('Switched with flag \"' + switch_flag + '\" flipped to state \"' + str(switch_state) + '\"!')
