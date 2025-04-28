extends Node2D

@onready var progress_bar = $ProgressBar
@onready var rich_text_label = $RichTextLabel
var time_taken = 0
var END_TIME = 34
var level_instance : Node2D

func _ready():
	await get_tree().create_timer(36.0).timeout
	load_level("Emerson_left_wing")
	AudioController.play_level1()

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

func sec_to_time(secs: int) -> String:
	var return_val = ""
	if(secs>=60):
		return_val = str(secs/60) + ":"
	else: return_val = "0:"
	
	if(secs%60<10):
		return_val += "0" + str(secs%60)
	else: return_val += str(secs%60)
	
	return return_val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_taken += delta
	if(time_taken<=END_TIME+1):
		$ProgressBar.value = time_taken
		$RichTextLabel.text = sec_to_time(time_taken) + "/0:34"
