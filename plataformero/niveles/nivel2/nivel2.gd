extends TileMapLayer

var hue: float = 0.0
@export var speed: float = 0.1
	
func _process(delta: float) -> void:
	hue = fmod(hue+delta*speed, 1.0)
	modulate = Color.from_hsv(hue, 0.7, 1.0) 
