class_name CassetteInteractable
extends Interactable

signal item_collected(item: Node2D)

## The item node to be removed when collected by a player.
## Defaults to this CollectableInteractable's parent if not specified.
@export var item_node: Node2D
@export var cinematic_name: String

func _ready() -> void:
	item_collected.connect(_on_item_collected)
	if not item_node: item_node = self.get_parent()

func _interact() -> void:
	AudioController.play_cinematic(cinematic_name)
	item_collected.emit(item_node)

func _on_item_collected(item: Node2D) -> void:
	print('Collecting item: ' + str(item))
	item.queue_free()

func set_cinematic_name(new_name: String):
	cinematic_name = new_name
