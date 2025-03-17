class_name HazardInteractable
extends Interactable

signal hazard_touched

func _ready() -> void:
	hazard_touched.connect(_on_hazard_touched)
	hitbox.body_shape_entered.connect(_on_hitbox_body_shape_entered)

func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hazard_touched.emit()

func _on_hazard_touched() -> void:
	print('Hazard touched!  Ordinarily this would kill the player.')
