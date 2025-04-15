extends Node2D

## The scene name to load when this door is interacted with.
@export var destination: String
	
	
func load_level(level_name : String):
	var level_path := "res://scenes/screens/%s.tscn" % level_name
	var level_resource := load(level_path)
	if(level_resource):
		get_tree().change_scene_to_file(level_path)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted() -> void:
	$AnimatedSprite2D.play()
	AudioController.play_door()


func _on_animated_sprite_2d_animation_finished() -> void:
	load_level(destination)
