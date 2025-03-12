class_name HeartGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

var value: int = 2:
	set(_value):
		value = _value
		UpdateSprite()


func UpdateSprite() -> void:
	sprite.frame = value
