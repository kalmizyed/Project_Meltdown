extends Node2D

@onready var main_2d : Node2D = $Main2D
@onready var camera : Camera2D = $Main2D/Camera2D
@onready var exit_button = $X
var level_instance : Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.visible = false # Replace with function body.
	camera.zoom = Vector2(3, 2.7)
	camera.position.y += 20
	
func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null
	
func load_level(level_name : String):
	unload_level()
	var level_path := "res://scenes/%s.tscn" % level_name
	var level_resource := load(level_path)
	if(level_resource):
		get_tree().change_scene_to_file(level_path)

func add_level(level_name : String):
	unload_level()
	var level_path := "res://scenes/%s.tscn" % level_name
	var level_resource := load(level_path)
	exit_button.visible = true; 
	if(level_resource):
		level_instance = level_resource.instantiate()
		main_2d.add_child(level_instance)

func _on_exit_pressed() -> void:
	load_level("title_screen") # Replace with function body.


func _on_inventory_pressed() -> void:
	add_level("inventory") # Replace with function body.
	


func _on_x_pressed() -> void:
	unload_level()
	exit_button.visible = false
