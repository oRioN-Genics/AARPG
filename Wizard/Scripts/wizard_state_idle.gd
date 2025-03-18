class_name Wizard_State_Idle extends WState

#@onready var walk: State = $"../Walk"
#@onready var attack: State = $"../Attack"
@onready var walk: Wizard_State_Walk = $"../Walk"
@onready var attack: Wizard_State_Attack = $"../Attack"

func Enter() -> void:
	player.UpdateAnimation("idle")
	pass


func Exit() -> void:
	pass


func Process(_delta: float) -> WState:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null


func Physics(_delta: float) -> WState:
	return null


func HandleInput(_event: InputEvent) -> WState:
	if _event.is_action_pressed("Attack"):
		return attack

	return null
