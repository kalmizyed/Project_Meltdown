extends CharacterBody2D

enum State { PATROL, CHASE }
var state = State.PATROL

@export var patrol_points: Array[Vector2]
@export var speed = 100
@export var chase_speed = 130
@export var detection_radius = 100.0

var current_patrol_index = 0
var player = null

@onready var detection_area = $Area2D
@onready var raycast = $RayCast2D

func _ready():
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))

func _physics_process(delta):
	match state:
		State.PATROL:
			_patrol(delta)
		State.CHASE:
			_chase(delta)

func _patrol(delta):
	var target_pos = patrol_points[current_patrol_index]
	var direction = (target_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	if global_position.distance_to(target_pos) < 10:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()

func _chase(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * chase_speed
		move_and_slide()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		state = State.CHASE
		print("Player detected! Chasing...")

func _on_body_exited(body):
	if body == player:
		player = null
		state = State.PATROL
		print("Lost sight of player. Resuming patrol.")
