extends CharacterBody2D

@export var SPEED: float = 300.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := {
		'x': Input.get_axis("ui_left", "ui_right"),
		'y': Input.get_axis("ui_up", "ui_down"),
	}
	
	velocity.x = direction['x'] * SPEED if direction['x'] else move_toward(velocity.x, 0, SPEED)
	velocity.y = direction['y'] * SPEED if direction['y'] else move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	AudioController.play_footsteps() # This might just play constantly idk
