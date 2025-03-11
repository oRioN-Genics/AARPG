class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction: Vector2)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()


func _physics_process(delta: float) -> void:
	move_and_slide()


func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false

	var direction_id: int = int(round( (direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size() ))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


func UpdateAnimation(state: String) -> void:
	var anim_direction: String = AnimDirection()
	animation_player.play(state + "_" + anim_direction)


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
