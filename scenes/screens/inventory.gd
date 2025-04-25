extends Node2D

@onready var my_image = $TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	my_image.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_1_pressed() -> void:
	print('1') # Replace with function body.


func _on_text_2_pressed() -> void:
	my_image.visible = true

func _input(event):
	if my_image.visible and event is InputEventMouseButton and event.pressed:
		my_image.visible = false
