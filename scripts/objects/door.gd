extends Node2D

## Tags of any switches that flip the state of this door.
@export var switches: Array[Node]

## Can be opened by the player directly.
@export var canOpen: bool

var isOpen: bool = false

func _switch_flipped(name, state) -> void:
	handle_open()

func handle_open() -> void:
	if isOpen:
		$AnimatedSprite2D.play_backwards()
		isOpen = false
	else:
		$AnimatedSprite2D.play()
		isOpen = true
	$StaticBody2D/CollisionShape2D.disabled = isOpen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for switch in switches:
		for child in switch.get_children():
			if child is SwitchInteractable:
				child.switch_flipped.connect(_switch_flipped)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if canOpen:
		handle_open()
