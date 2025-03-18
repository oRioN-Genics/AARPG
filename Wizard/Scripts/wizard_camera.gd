class_name PlayerCamera extends Camera2D

var move_speed: float = 150.0
var lerp_factor: float = 0.5
var is_mouse_outside: bool = false

var camera_error_correction: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_bounds)
	
	await _find_hud()


func _find_hud() -> void:
	while true:
		var hud_instances = get_tree().get_nodes_in_group("player_hud")
		if hud_instances.size() > 0:
			var hud_instance = hud_instances[0]  
			var camera_move_edge = hud_instance.get_node_or_null("CameraMoveEdge")

			if camera_move_edge:
				camera_move_edge.MouseOutsideEllipse.connect(_on_mouse_outside_ellipse)
				print("PlayerHUD found and connected to CameraMoveEdge!")
				break  
			else:
				print("Error: CameraMoveEdge not found in PlayerHUD!")

		await get_tree().create_timer(0.1).timeout 


func _on_mouse_outside_ellipse(is_outside: bool) -> void:
	is_mouse_outside = is_outside 
	
	
func UpdateLimits(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return

	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y + camera_error_correction)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
	
	
func _process(delta: float) -> void:
	if is_mouse_outside:
		var viewport_size = get_viewport_rect().size
		var center = viewport_size * 0.5
		var mouse_pos = get_viewport().get_mouse_position()
		
		var distance = center.distance_to(mouse_pos)
		
		var direction = center.direction_to(mouse_pos)
		var move_vector = direction * distance * 0.01
		
		var target_position = position + move_vector * move_speed
		position = position.lerp(target_position, delta * lerp_factor)
