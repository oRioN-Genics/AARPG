extends CanvasLayer

var hearts: Array[HeartGUI] = []

func _ready() -> void:
	pass


func UpdateHP(_hp: int, _max_hp: int) -> void:
	UpdateMaxHP(_max_hp)
	for i in _max_hp:
		UpdateHeart(i, _hp)


func UpdateHeart(_index: int, _hp: int) -> void:
	var _value: int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value


func UpdateMaxHP(_max_hp: int) -> void:
	var _heart_count: int = roundi(_max_hp * 0.5)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
