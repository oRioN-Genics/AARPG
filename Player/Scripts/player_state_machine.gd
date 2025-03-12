class_name PlayerStateMachine extends Node

var states: Array [State]
var prev_state: State
var current_state: State 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(current_state.Process(delta))


func _physics_process(delta: float) -> void:
	ChangeState(current_state.Physics(delta))


func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(event))


func Initialize(_player: Player) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() == 0:
		return
		
	states[0].player = _player
	states[0].state_machine = self
	
	for state in states:
		state.Init()
	
	ChangeState( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT
	
	
func ChangeState(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
