class_name ContainerInteractable
extends Interactable

signal container_opened(container: ContainerInteractable)

## Items in this container.  Usually nodes with CollectableInteractable children.
@export var items: Array[Node2D]

func _ready() -> void:
	pass

func _interact() -> void:
	container_opened.emit(self)

func addItem(item: Node2D):
	items.append(item)

func removeItem(item: Node2D):
	items = items.filter(func(oldItem): return oldItem != item)
