extends CharacterBody2D

@onready var animated_sprite = $Sprite2D
@onready var aniTree : AnimationTree = $AnimationTree
@onready var timer = $DeathTimer
var direction: Vector2 = Vector2.ZERO
const SPEED : int = 100
var deceased = false;


func _ready():
	aniTree.active = true

func _process(_delta):
	update_animation_parameters()


func _physics_process(delta):
	if deceased == false:

		if Input.is_action_just_pressed("hide"):
			print("Ahh so scary I must hide Aaaahhhh")
	
		if Input.is_action_just_pressed("interact"):
			print("Interaction oh shi waht's this?")
		
		if Input.is_action_just_pressed("grab"):
			print("Ohh Shiny dis shi is mine")
		
		if Input.is_action_just_pressed("flashlight"):
			print("The power of the sun the the palm of my hand")


	# Get the input direction and handle the movement/deceleration.
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		if Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
			direction.y=0
		elif Input.is_action_just_pressed("up") || Input.is_action_just_pressed("down"):
			direction.x=0
	
		velocity = direction * SPEED
	
	# Plays footsteps if the player is moving
		if(velocity.length()!=0):
			if($Timer.time_left<=0):
				AudioController.play_footsteps_with_reverb()
				$Timer.start(0.2)
	
		move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Alien"):
		print("AUHFOiehfna;eorgliuaenv I've died")
		deceased = true;
		aniTree["parameters/conditions/is_dead"] = true
		timer.start()
		
func _on_death_timer_timeout():
	deceased = false;
	print("OhWOW")
	aniTree["parameters/conditions/is_dead"] = false
	get_tree().reload_current_scene()
	
	
	
func update_animation_parameters():
	if velocity == Vector2.ZERO:
		aniTree["parameters/conditions/idle"] = true
		aniTree["parameters/conditions/is_moving"] = false
		
	else:
		aniTree["parameters/conditions/idle"] = false
		aniTree["parameters/conditions/is_moving"] = true
	
	if (Input.is_action_just_pressed("grab")):
		aniTree["parameters/conditions/yoink"] = true
	else:
		aniTree["parameters/conditions/yoink"] = false

	if Input.is_action_just_pressed("push") || Input.is_action_just_pressed("interact"):
		aniTree["parameters/conditions/push"] = true
	else:
		aniTree["parameters/conditions/push"] = false
		
	if Input.is_action_just_pressed("hide"):
		aniTree["parameters/conditions/hiding"] = true
	else:
		aniTree["parameters/conditions/hiding"] = false
		
	aniTree["parameters/Idle/blend_position"] = direction
	aniTree["parameters/Walk/blend_position"] = direction
	aniTree["parameters/Grab/blend_position"] = direction
	aniTree["parameters/Push/blend_position"] = direction
