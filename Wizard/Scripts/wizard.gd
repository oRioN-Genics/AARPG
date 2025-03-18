class_name Wizard extends CharacterBody2D

signal DirectionChanged(new_direction: Vector2)
signal PlayerDamaged(hurt_box: HurtBox)

@export var speed: float = 150.0
var acceleration: float = 7

var cardinal_direction: Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction: Vector2 = Vector2.ZERO

var invulnerable: bool = false
var hp: int = 6
var max_hp: int = 6

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var right_click_scene = preload("res://Player/right_click.tscn")
@onready var hit_box: HitBox = $HitBox
@onready var sprite: Sprite2D = $Sprite2D  
@onready var state_machine: WizardStateMachine = $StateMachine
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.wizard = self
	state_machine.Initialize(self)
	hit_box.Damaged.connect(_TakeDamage)
	UpdateHP(99)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		nav_agent.target_position = get_global_mouse_position()
		var r_click = right_click_scene.instantiate()
		r_click.global_position = nav_agent.target_position
		get_tree().current_scene.add_child(r_click)
		

func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		direction = Vector2.ZERO
		nav_agent.debug_enabled = false
	else:
		direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		nav_agent.debug_enabled = true
		
		velocity = velocity.lerp(direction * speed, acceleration * _delta)
		
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


func _TakeDamage(hurt_box: HurtBox) -> void:
	if invulnerable == true:
		return
	
	UpdateHP(-hurt_box.damage)
	if hp > 0:
		PlayerDamaged.emit(hurt_box)
	else:
		PlayerDamaged.emit(hurt_box)
		UpdateHP(99)
	pass


func UpdateHP(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.UpdateHP(hp, max_hp)
	pass


func MakeInvulnarable(_duration: float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	invulnerable = false
	hit_box.monitoring = true
	pass
