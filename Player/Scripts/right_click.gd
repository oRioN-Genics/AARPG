extends Node2D

@onready var click_anim: AnimationPlayer = $ClickAnim


func _ready() -> void:
	click_anim.play("click")  # Play animation automatically
	click_anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name):
	queue_free()  # Remove ripple after animation ends
