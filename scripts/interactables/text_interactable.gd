class_name TextInteractable
extends Interactable

signal text_popped_up(txt: String)

## The text to be displayed when this item is interacted with.
@export var text: String
## The type of text interactable this object is, book or paper
@export var object_type: String 

func _ready() -> void:
	pass

func _interact() -> void:
	if(object_type=="book"):
		AudioController.play_book_pickup()
	if(object_type=="paper"):
		AudioController.play_paper_pickup()
	text_popped_up.emit(text)
