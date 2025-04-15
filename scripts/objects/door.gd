extends Node2D

## Tags of any switches that flip the state of this door.
## If allSwitchesRequired is true, every switch in this list must be on for the door to open.
@export var switches: Array[Node]
var switchStates: Dictionary

## Can be opened by the player directly.
@export var canOpen: bool

## If this is enabled, the door will only open if every connected switch is turned on.
## Make sure each required switch node has a unique name for this to work properly.
@export var allSwitchesRequired: bool

var isOpen: bool = false

func passes_requirements() -> bool:
	for enabled in switchStates.values():
		if not enabled: return false
	return true

func _switch_flipped(name, state) -> void:
	# Track the state of this switch
	switchStates[name] = state
	
	# Handle opening/closing the door depending on switch rules
	if allSwitchesRequired:
		if passes_requirements():
			open_door()
		else:
			close_door()
	else:
		handle_open()

func handle_open() -> void:
	AudioController.play_door()
	if isOpen:
		close_door()
	else:
		open_door()
	$StaticBody2D/CollisionShape2D.disabled = isOpen

func open_door() -> void:
	if not isOpen:
		$AnimatedSprite2D.play()
		isOpen = true

func close_door() -> void:
	if isOpen:
		$AnimatedSprite2D.play_backwards()
		isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for switch in switches:
		for child in switch.get_children():
			if child is SwitchInteractable:
				child.switch_flipped.connect(_switch_flipped)
				switchStates[switch.name] = child.state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if canOpen:
		handle_open()
