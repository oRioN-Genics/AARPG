class_name Plant extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)


func TakeDamage(_damage: int) -> void:
	queue_free()
