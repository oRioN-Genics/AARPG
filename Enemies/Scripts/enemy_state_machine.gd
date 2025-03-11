class_name EnemyStateMachine extends Node

var states: Array [EnemyState]
var prev_state: EnemyState
var current_state: EnemyState 


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	ChangeState(current_state.Process(delta))


func _physics_process(delta: float) -> void:
	ChangeState(current_state.Physics(delta))


func Initialize(_enemy: Enemy) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			states.append(c)
	
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT


func ChangeState(new_state: EnemyState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
