extends Node2D

@onready var hud : Control = $HUD
@onready var title : Control = $Title
@onready var main_2d : Node2D = $Main2D
@onready var camera : Camera2D = $Main2D/Camera
var level_instance : Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null
	
func load_level(level_name : String):
	unload_level()
	var level_path := "res://scenes/screens/%s.tscn" % level_name
	var level_resource := load(level_path)
	if(level_resource):
		get_tree().change_scene_to_file(level_path)


func _on_return_pressed() -> void:
	load_level("Emerson_left_wing") # Replace with function body.


func _on_inventory_pressed() -> void:
	load_level("Emerson_left_wing") # Replace with function body.


func _on_start_pressed() -> void:
	## remove this line and uncomment others when done
	load_level("Emerson_left_wing")
	##load_level("transition_cinematic") # Replace with function body.
	##AudioController.stop_main_menu()
