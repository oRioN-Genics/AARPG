class_name EnemyStateIdle extends EnemyState

@export var anim_name: String = "idle"

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var after_idle_state: EnemyState

var _timer: float = 0.0

## what happens when we initialize this state
func init() -> void:
	pass


## what happens when enemy enters this state	
func Enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.UpdateAnimation(anim_name)
	pass


## what happens when enemy exits this state	
func Exit() -> void:
	pass
	

## what happens during the _process update in this state
func Process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	
	return null


## what happens during the _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
