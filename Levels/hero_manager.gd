class_name HeroManager extends Node2D

signal HeroSelected(hero)

const HERO_COLLISION_MASK = 4

var selected_hero = null


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var hero = raycast_check_for_heroes()
			if hero:
				select_hero(hero)


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


func select_hero(new_hero):
	if selected_hero == new_hero:
		return  

	if selected_hero and selected_hero.sprite and selected_hero.sprite.material:
		var old_material = selected_hero.sprite.material.duplicate()
		selected_hero.sprite.material = old_material
		selected_hero.sprite.material.set_shader_parameter("outline_alpha", 0.0)

	selected_hero = new_hero
	if selected_hero and selected_hero.sprite:
		var new_material = selected_hero.sprite.material.duplicate()
		selected_hero.sprite.material = new_material
		selected_hero.sprite.material.set_shader_parameter("outline_alpha", 1.0)

	HeroSelected.emit(selected_hero)
