extends Node2D

@onready var alnUT = $AlnUntrans
@onready var alnT = $AlnTrans
@onready var trans = $Trans
@onready var boolean = $Bool
@onready var one = $TextureRect
@onready var two = $TextureRect2
@onready var three = $TextureRect3
@onready var four = $TextureRect4
@onready var five = $TextureRect5
@onready var six = $TextureRect6
@onready var seven = $TextureRect7


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	alnUT.visible = false
	alnT.visible = false
	trans.visible = false
	boolean.visible = false
	one.visible = false
	two.visible = false
	three.visible = false
	four.visible = false
	five.visible = false
	six.visible = false
	seven.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_1_pressed() -> void:
	if InventorySystem.is_collected("Trans"):
		alnT.visible = true
	else:
		alnUT.visible = true


func _on_text_2_pressed() -> void:
	trans.visible = true

func _input(event):
	if alnUT.visible and event is InputEventMouseButton and event.pressed:
		alnUT.visible = false
	if alnT.visible and event is InputEventMouseButton and event.pressed:
		alnT.visible = false
	if trans.visible and event is InputEventMouseButton and event.pressed:
		trans.visible = false
	if boolean.visible and event is InputEventMouseButton and event.pressed:
		boolean.visible = false	
	if one.visible and event is InputEventMouseButton and event.pressed:
		one.visible = false	
	if two.visible and event is InputEventMouseButton and event.pressed:
		two.visible = false	
	if three.visible and event is InputEventMouseButton and event.pressed:
		three.visible = false	
	if four.visible and event is InputEventMouseButton and event.pressed:
		four.visible = false		
	if five.visible and event is InputEventMouseButton and event.pressed:
		five.visible = false	
	if six.visible and event is InputEventMouseButton and event.pressed:
		six.visible = false	
	if seven.visible and event is InputEventMouseButton and event.pressed:
		seven.visible = false		


func _on_text_3_pressed() -> void:
	boolean.visible = true # Replace with function body.


func _on_button_1_pressed() -> void:
	one.visible = true # Replace with function body.


func _on_button_2_pressed() -> void:
	two.visible = true # Replace with function body.


func _on_button_3_pressed() -> void:
	three.visible = true # Replace with function body.


func _on_button_5_pressed() -> void:
	five.visible = true # Replace with function body.


func _on_button_4_pressed() -> void:
	four.visible = true # Replace with function body.


func _on_button_6_pressed() -> void:
	six.visible = true # Replace with function body.


func _on_button_7_pressed() -> void:
	seven.visible = true # Replace with function body.
