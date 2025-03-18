class_name Wizard_State_Walk extends WState

@export var move_speed: float = 100.0

#@onready var idle: State = $"../Idle"
#@onready var attack: State = $"../Attack"
@onready var idle: Wizard_State_Idle = $"../Idle"
@onready var attack: Wizard_State_Attack = $"../Attack"


func Enter() -> void:
	player.UpdateAnimation("walk")
	pass


func Exit() -> void:
	pass


func Process(_delta: float) -> WState:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
		
	return null


func Physics(_delta: float) -> WState:
	return null


func HandleInput(_event: InputEvent) -> WState:
	if _event.is_action_pressed("Attack"):
		return attack
		
	return null
