extends Node2D

@export var group_name : String

const SPEED = 80
var pos: Array
var temp_pos: Array
var curr_pos: Marker2D
var direction: Vector2 = Vector2.ZERO

enum{
	WANDERING,
	HUNTING,
}

var state = WANDERING

func _ready():
	pos = get_tree().get_nodes_in_group(group_name)
	get_positions()
	get_next_position()
	

func _process(_delta):
	if global_position.distance_to(curr_pos.position) < 10:
		get_next_position()
	#position.x += direction * SPEED * delta
	
func get_positions():
	temp_pos = pos.duplicate()
	temp_pos.shuffle()
	
func get_next_position():
	if temp_pos.is_empty():
		get_positions()
	curr_pos = temp_pos.pop_front()
	direction = to_local(curr_pos.position).normalized()
	
