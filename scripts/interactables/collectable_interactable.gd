class_name CollectableInteractable
extends Interactable

signal item_collected(item: Node2D)

## The item node to be removed when collected by a player.
## Defaults to this CollectableInteractable's parent if not specified.
@export var item_node: Node2D

func _ready() -> void:
	item_collected.connect(InventorySystem.on_item_collected)
	if not item_node: item_node = self.get_parent()

func _interact() -> void:
	print("Item collected:", item_node.name)
	AudioController.play_misc_pickup()
	item_collected.emit(item_node)
	item_node.get_parent().remove_child(item_node)
