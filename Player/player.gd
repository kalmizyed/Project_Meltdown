extends CharacterBody2D

@onready var animated_sprite = 

const SPEED : int = 500
var direction: Vector2 = Vector2.ZERO



func _physics_process(delta):


	if Input.is_action_just_pressed("Hide"):
		print("Ahh so scary I must hide Aaaahhhh")
	
	if Input.is_action_just_pressed("Interact"):
		print("Interaction oh shi waht's this?")
		
	if Input.is_action_just_pressed("Grab"):
		print("Ohh Shiny dis shi is mine")


	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("Left", "Right", "Up", "Down").normalize()
	if Input.is_action_just_pressed("Left") || Input.is_action_just_pressed("Right"):
		direction.y=0
	elif Input.is_action_just_pressed("Up") || Input.is_action_just_pressed("Down"):
		direction.x=0
	else:
		direction = Vector2.ZERO

	velocity = direction * SPEED
	move_and_slide()
