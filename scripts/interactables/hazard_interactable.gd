class_name HazardInteractable
extends Interactable

signal hazard_touched

func _ready() -> void:
	pass

func _entered() -> void:
	hazard_touched.emit()
