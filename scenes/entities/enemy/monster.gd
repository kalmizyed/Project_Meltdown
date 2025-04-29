extends CharacterBody2D

enum State { LEAVE, PATROL, CHASE }
var state = State.LEAVE

@export var escape_point: Vector2
@export var patrol_points: Array[Vector2]
@export var speed = 50
@export var chase_speed = 100
@export var detection_radius = 100.0

var current_patrol_index = 0
var player = null

@onready var detection_area = $Area2D
@onready var raycast = $RayCast2D
@onready var animation = $Sprite2D

func _ready():
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))
	animation.play("Front Facing")

func _physics_process(_delta):
	#update_animation()
	match state:
		State.LEAVE:
			_leave(_delta)
		State.PATROL:
			_patrol(_delta)
		State.CHASE:
			_chase(_delta)

func _leave(_delta):
	var escape_pos = escape_point
	var direction = (escape_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if global_position.distance_to(escape_pos) < 10:
		state=State.PATROL

func _patrol(_delta):
	var target_pos = patrol_points[current_patrol_index]
	var direction = (target_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	if global_position.distance_to(target_pos) < 10:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()

func _chase(_delta):
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
		
		
#func update_animation():
		
