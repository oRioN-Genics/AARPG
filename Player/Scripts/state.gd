class_name State extends Node

## stores a reference to the player that this State belongs to
static var player: Player
static var state_machine: PlayerStateMachine


func _ready() -> void:
	pass # Replace with function body.


func Init() -> void:
	pass


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
