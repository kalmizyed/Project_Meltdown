class_name ContainerInteractable
extends Interactable

signal container_opened(container: ContainerInteractable)

## Items in this container.  Usually nodes with CollectableInteractable children.
@export var items: Array[Node2D]

func _ready() -> void:
	container_opened.connect(_on_container_opened)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and hitbox and hitbox.has_overlapping_bodies():
		container_opened.emit(self)

func addItem(item: Node2D):
	items.append(item)

func removeItem(item: Node2D):
	items = items.filter(func(oldItem): return oldItem != item)

func _on_container_opened(container: ContainerInteractable) -> void:
	print('Opened container with ' + str(items.size()) + ' items: ' + str(items))
