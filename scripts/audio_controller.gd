extends Node2D

@export var mute: bool = false
@export var mute_music: bool = false

func _ready():
	if not mute_music:
		play_music()

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

func play_music():
	if not mute:
		$Music.play()

func play_door() -> void:
	if not mute:
		$Door.play()

func play_paper_pickup() -> void:
	if not mute:
		# Add random functionality between paper 1 and 2 sfx
		$Paper.play()

func play_footsteps() -> void:
	# If you're having issues with this playing constantly, 
	# look in player_placeholder.gd
	if not mute:
		$Footsteps.play()

func play_footsteps_with_reverb() -> void:
	if not mute:
		$FootstepsReverb.pitch_scale = randf_range(0.7, 1) # This range can be tweaked
		$FootstepsReverb.play()

func play_bag_open() -> void:
	if not mute:
		$Bag.play()

func play_book_pickup() -> void:
	if not mute:
		$Book.play()

func play_cinematic(cinematic_name : String):
	var cinematic_path := "res://assets/cinematics/%s.mp3" % cinematic_name
	$CinematicPlayer.stream = load_mp3(cinematic_path)
	if not mute:
		$Music.stop()
		$CinematicPlayer.play()


func _on_cinematic_player_finished():
	await get_tree().create_timer(1.0).timeout
	$Music.play()
