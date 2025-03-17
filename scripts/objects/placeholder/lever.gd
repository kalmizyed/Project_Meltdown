extends StaticBody2D

@onready var sprite = $AnimatedSprite2D

func _on_switch_interactable_switch_flipped(switch_flag: String, switch_state: bool) -> void:
	if switch_flag == "Lever":
		sprite.frame = int(switch_state) * 2
