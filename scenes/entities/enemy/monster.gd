extends Node2D

const SPEED = 60

var direction = 1

func _process(delta):
	position.x += direction * SPEED * delta
	
	
