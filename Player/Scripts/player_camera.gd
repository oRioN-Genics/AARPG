class_name PlayerCamera extends Camera2D

var edge_margin: int = 60
var move_speed: float = 200.0
var camera_error_correction: int = 10
var lerp_factor: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_bounds)


func UpdateLimits(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return

	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y + camera_error_correction)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
	
	
func _process(delta: float) -> void:
	var viewport_size = get_viewport_rect().size
	var center = viewport_size * 0.5
	var mouse_pos = get_viewport().get_mouse_position()
	
	var distance = center.distance_to(mouse_pos)
	
	if distance > edge_margin:
		var direction = center.direction_to(mouse_pos)
		var move_vector = direction * ((distance - edge_margin) * 0.01)  
		
		var target_position = position + move_vector * move_speed
		position = position.lerp(target_position, delta * lerp_factor)
