extends Node2D

@export var mute: bool = false
@export var mute_music: bool = false

func _ready():
	if not mute_music:
		play_music()

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
		$FootstepsReverb.pitch_scale = randf_range(0.7, 1)
		$FootstepsReverb.play()

func play_bag_open() -> void:
	if not mute:
		$Bag.play()

func play_book_pickup() -> void:
	if not mute:
		$Book.play()
