extends Node2D

# TODO: balance audio volume
# TODO: implement locker sfx?
# TODO: implement light sfx?
# TODO: implement locked door sfx
# TODO: implement fire sfx

@export var mute_sfx: bool = false # Mutes all sound effects
@export var mute_music: bool = false # Mutes all music
@export var mute_cinematics: bool = false # Mutes cinematics played through audio controller
var last_num = 1 # stores the last played numpad value, default 1
var music_playing # Tracks the song currently being played

func _ready():
	play_main_menu()

# Takes a file path and converts it to an AudioStream
func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

# Plays the main menu music
func play_main_menu():
	if not mute_music:
		$MainMenu.play()
		music_playing = "main_menu"

# Plays the level 1 music
func play_level1():
	if not mute_music:
		$Level1.play()
		music_playing = "level1"

# Plays the credits music
func play_credits():
	if not mute_music:
		$Credits.play()
		music_playing = "credits"

# Plays the door opening sound effect
func play_door() -> void:
	if not mute_sfx:
		$Door.play()

# Play paper pickup sound effect, random choice of 2 options
func play_paper_pickup() -> void:
	if not mute_sfx:
		var sfx = randi_range(0, 1)
		if sfx==1:
			$Paper.play()
		else:
			$Paper2.play()

# Play footsteps with reverb sound effect, with varying pitch scale
func play_footsteps_with_reverb() -> void:
	if not mute_sfx:
		$FootstepsReverb.pitch_scale = randf_range(0.7, 1) # This range can be tweaked
		$FootstepsReverb.play()

# Play the bag open sound effect
func play_bag_open() -> void:
	if not mute_sfx:
		$BagOpen.play()

# Plays a random bag close sound effect of the 2 options
func play_bag_close():
	var sfx = randi_range(0, 1)
	
	if sfx==1:
		$BagClsoe.stream = load_mp3("res://assets/sfx/bag_close_1.mp3")
	else:
		$BagClose.stream = load_mp3("res://assets/sfx/bag_close_2.mp3")
	
	if not mute_sfx:
		$BagClose.play()

# Plays the book pickup sound effect
func play_book_pickup() -> void:
	if not mute_sfx:
		$Book.play()

# Plays a cinematic given its name
func play_cinematic(cinematic_name : String):
	var music_playing
	var cinematic_path := "res://assets/cinematics/%s.mp3" % cinematic_name
	$CinematicPlayer.stream = load_mp3(cinematic_path)
	if not mute_cinematics:
		$MainMenu.stop()
		$Level1.stop()
		$Credits.stop()
		mute_music = true
		mute_sfx = true
		$CinematicPlayer.play()

# Chooses a random int value that is not the last played numpad sound effect number
# and plays that sound effect
func play_numpad():
	var options = [randi_range(1, last_num - 1), randi_range(last_num + 1, 9)]
	var choice = options.pick_random()
	var sfx_path = "res://assets/sfx/numpad_%s.mp3" % choice
	$NumPad.stream = load_mp3(sfx_path)
	if not mute_sfx:
		$NumPad.play()
	last_num = choice

# Plays a random misc pickup sound effect of the 2 options
func play_misc_pickup():
	var sfx = randi_range(0, 1)
	
	if sfx==1:
		$MiscPickup.stream = load_mp3("res://assets/sfx/misc_pickup_1.mp3")
	else:
		$MiscPickup.stream = load_mp3("res://assets/sfx/misc_pickup_1.mp3")
	
	if not mute_sfx:
		$MiscPickup.play()

# Restarts music after a cinematic finishes
func _on_cinematic_player_finished():
	mute_sfx = false
	await get_tree().create_timer(1.0).timeout
	mute_music = false
	if(music_playing=="main_menu"):
		play_main_menu()
	elif(music_playing=="level1"):
		play_level1()
	else:
		play_credits()
