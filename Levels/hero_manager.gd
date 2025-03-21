class_name HeroManager extends Node2D

signal HeroSelected(hero)

const HERO_COLLISION_MASK = 4

var hero_being_selected = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var hero = raycast_check_for_heroes()
			if hero:
				hero_being_selected = hero
				HeroSelected.emit(hero_being_selected)
				hero_being_selected = null
		hero_being_selected = null


func raycast_check_for_heroes():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = HERO_COLLISION_MASK
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	return null
