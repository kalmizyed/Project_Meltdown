extends Node2D

## List of objects in the scene with a SwitchInteractable as a child, e.g. levers.
## If any of those objects is switched, the door will flip states.
@export var switches: Array[Node]

## List of objects in the scene with a SwitchInteractable as a child, e.g. levers.
## If there are objects in this list, all of them must be switched on for the door to open.
## Make sure each required switch node has a unique name for this to work properly.
@export var onSwitches: Array[Node]

## List of objects in the scene with a SwitchInteractable as a child, e.g. levers.
## If there are objects in this list, all of them must be switched off for the door to open.
## Make sure each required switch node has a unique name for this to work properly.
@export var offSwitches: Array[Node]

var switchStates: Dictionary

## Can be opened by the player directly.
@export var canOpen: bool

## Any items required to be able to open the door by hand, if any.
@export var items: Array[Node]

var isOpen: bool = false

func passes_item_requirements() -> bool:
	if items.size() > 0:
		for item in items:
			if item not in InventorySystem.items:
				print('NOT FOUND: ' + str(item))
				return false
	return true

func passes_requirements() -> bool:
	# Check required on/off switches
	for switch in onSwitches:
		if switchStates[switch.name] != true:
			return false
	for switch in offSwitches:
		if switchStates[switch.name] != false:
			return false
	return true

func _switch_flipped(name, state) -> void:
	# Track the state of this switch
	switchStates[name] = state
	
	# Handle opening/closing the door depending on switch rules
	handle_open()

func handle_open() -> void:
	if onSwitches.size() > 0 or offSwitches.size() > 0:
		if passes_requirements():
			open_door()
		else:
			$DoorLocked.play()
			close_door()
	else:
		if isOpen:
			close_door()
		else:
			open_door()
	$StaticBody2D/CollisionShape2D.disabled = isOpen

func open_door() -> void:
	if not isOpen:
		$AnimatedSprite2D.play()
		AudioController.play_door()
		isOpen = true

func close_door() -> void:
	if isOpen:
		$AnimatedSprite2D.play_backwards()
		AudioController.play_door()
		isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var allSwitches: Array[Node] = []
	allSwitches.append_array(switches)
	allSwitches.append_array(onSwitches)
	allSwitches.append_array(offSwitches)
	for switch in allSwitches:
		for child in switch.get_children():
			if child is SwitchInteractable:
				child.switch_flipped.connect(_switch_flipped)
				switchStates[switch.name] = child.state
	if onSwitches.size() > 0 or offSwitches.size() > 0:
		if passes_requirements():
			open_door()
		else:
			close_door()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	if canOpen and passes_item_requirements():
		handle_open()
	else:
		$DoorLocked.play()
