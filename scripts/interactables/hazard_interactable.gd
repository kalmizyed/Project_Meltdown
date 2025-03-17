class_name HazardInteractable
extends Interactable

signal hazard_touched

func _ready() -> void:
	hazard_touched.connect(_on_hazard_touched)

func _entered() -> void:
	hazard_touched.emit()

func _on_hazard_touched() -> void:
	print('Hazard touched!  Ordinarily this would kill the player.')
