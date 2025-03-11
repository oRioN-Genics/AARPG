class_name EnemyState extends Node

var enemy: Enemy 
var state_machine: EnemyStateMachine

## what happens when we initialize this state
func init() -> void:
	pass


## what happens when enemy enters this state	
func Enter() -> void:
	pass


## what happens when enemy exits this state	
func Exit() -> void:
	pass
	

## what happens during the _process update in this state
func Process(_delta: float) -> EnemyState:
	return null


## what happens during the _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
