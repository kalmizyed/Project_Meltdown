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

@onready var detection_area = $DetectionArea
@onready var raycast = $RayCast2D
@onready var aniTree = $AnimationTree
@onready var animation = $Sprite2D
@onready var timer = $Timer

func _ready():
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))

func _physics_process(_delta):
	match state:
		State.LEAVE:
			_leave(_delta)
		State.PATROL:
			_patrol(_delta)
		State.CHASE:
			_chase(_delta)

func _leave(_delta):
	#NOTE ON _leave(_delta): Needs one designated coordinate for the game to run
	var escape_pos = escape_point
	var direction = (escape_pos - global_position).normalized()
	velocity = direction * speed
	update_animation(velocity)
	move_and_slide()
	
	if global_position.distance_to(escape_pos) < 10:
		state=State.PATROL

func _patrol(_delta):
	#NOTE ON MONSTER: The monster can only work if you designate at least one coordinate for the monster to travel to
	var target_pos = patrol_points[current_patrol_index]
	var direction = (target_pos - global_position).normalized()
	velocity = direction * speed
	update_animation(velocity)
	move_and_slide()

	if global_position.distance_to(target_pos) < 10:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()

func _chase(_delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * chase_speed
		update_animation(velocity)
		move_and_slide()
		
func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		state = State.CHASE
		print("Player detected! Chasing...")
		
func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		state = State.PATROL
		print("Lost sight of player. Resuming patrol.")
		
		
func update_animation(velocity):
	if velocity.x > 0 || velocity.y > 0 || velocity.x < 0 || velocity.y < 0:
		aniTree["parameters/Movement/blend_position"] = velocity
		
		
		
