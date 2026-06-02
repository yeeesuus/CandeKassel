extends Camera2D

# cantidad de movimiento de la cámara hacia arriba (más significa más rápido)
@export var mov: int = 45

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y -= mov * delta 
