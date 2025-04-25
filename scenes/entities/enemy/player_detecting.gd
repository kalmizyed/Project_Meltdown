extends Node2D

@onready var raycast = $RayCast2D

func _process(delta):
	raycast.force_raycast_update()
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Player"):
			print("Player in sight!")
