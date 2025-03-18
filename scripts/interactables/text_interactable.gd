class_name TextInteractable
extends Interactable

signal text_popped_up(txt: String)

## The text to be displayed when this item is interacted with.
@export var text: String

func _ready() -> void:
	text_popped_up.connect(_on_text_popped_up)

func _interact() -> void:
	AudioController.play_paper_pickup()
	text_popped_up.emit(text)

func _on_text_popped_up(txt: String) -> void:
	print(txt)
