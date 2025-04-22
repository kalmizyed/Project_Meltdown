extends Node2D

@onready var progress_bar = $ProgressBar
@onready var rich_text_label = $RichTextLabel
var time_taken = 0
var END_TIME = 65

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioController.play_cinematic("robbie_cant_find_worker")

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
	if(time_taken<END_TIME):
		$ProgressBar.value = time_taken
		$RichTextLabel.text = sec_to_time(time_taken) + "/1:05"
	#else:
		#if(time_taken-2>=END_TIME): #wait 2 seconds then switch scenes
			#load next level
