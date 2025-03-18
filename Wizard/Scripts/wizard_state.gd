class_name WState extends Node

## stores a reference to the player that this State belongs to
static var player: Wizard
static var state_machine: WizardStateMachine


func _ready() -> void:
	pass # Replace with function body.


func Init() -> void:
	pass


func Enter() -> void:
	pass


func Exit() -> void:
	pass


func Process(_delta: float) -> WState:
	return null


func Physics(_delta: float) -> WState:
	return null


func HandleInput(_event: InputEvent) -> WState:
	return null
