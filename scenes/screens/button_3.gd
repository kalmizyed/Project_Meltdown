extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if InventorySystem.is_collected("key3"):
		set_disabled(false)
	else:
		set_disabled(true) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
