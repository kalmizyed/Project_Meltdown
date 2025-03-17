class_name DoorInteractable
extends Interactable

## A path to the scene file the door should load upon interaction.
@export var destination: String

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and hitbox and hitbox.has_overlapping_bodies():
		print('Door opened!  This would switch the scene to the one located at ' + destination + '.')
