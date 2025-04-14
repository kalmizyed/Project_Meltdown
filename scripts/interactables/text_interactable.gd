class_name TextInteractable
extends Interactable

signal text_popped_up(txt: String)

## The text to be displayed when this item is interacted with.
@export var text: String

func _ready() -> void:
	pass

func _interact() -> void:
	AudioController.play_book_pickup()
	text_popped_up.emit(text)
