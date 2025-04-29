extends Node2D

@onready var player = $player

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerPositionTracker.hasPosition(self.name):
		player.position = PlayerPositionTracker.getPosition(self.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	PlayerPositionTracker.setPosition(self.name, player.position)
