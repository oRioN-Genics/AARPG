extends Node

signal MouseOutsideEllipse(isOutside: bool)


func _on_area_2d_mouse_entered() -> void:
	MouseOutsideEllipse.emit(false)


func _on_area_2d_mouse_exited() -> void:
	MouseOutsideEllipse.emit(true)
