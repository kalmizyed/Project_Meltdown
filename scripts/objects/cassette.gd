extends StaticBody2D

@export var cinematic_name: String

func _ready():
	$CassetteInteractable.set_cinematic_name(cinematic_name)
