class_name Interactable
extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

## Called when the player uses the "interact" action while in the interactable's hitbox.
func _interact() -> void:
	pass
	
## Called when the player enters the interactable's hitbox.
func _entered() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and self.has_overlapping_bodies():
		_interact()

func _on_body_entered(_body: Node2D) -> void:
	_entered()
