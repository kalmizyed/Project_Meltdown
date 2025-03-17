class_name DoorInteractable
extends Interactable

## A path to the scene file the door should load upon interaction.
@export var destination: String

func _interact() -> void:
	print('Door opened!  This would switch the scene to the one located at ' + destination + '.')
