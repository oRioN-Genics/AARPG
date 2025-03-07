class_name State extends Node

## stores a reference to the player that this State belongs to
static var player: Player


func _ready() -> void:
	pass # Replace with function body.


func Enter() -> void:
	pass


func Exit() -> void:
	pass


func Process(_delta: float) -> State:
	return null


func Physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null
