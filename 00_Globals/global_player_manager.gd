extends Node

const PLAYER = preload("res://Player/Knight/player.tscn")
const WIZARD = preload("res://Player/Wizard/wizard.tscn")

var player: Player
var player_spawned: bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	

func add_player_instance() -> void:
	#player = PLAYER.instantiate()
	player = WIZARD.instantiate()
	add_child(player)


func set_player_position(_new_pos: Vector2) -> void:
	player.global_position = _new_pos


func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)


func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)
