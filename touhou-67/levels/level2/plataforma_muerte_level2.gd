extends AnimatableBody2D

# cantidad de movimiento de la plataforma hacia arriba
# DEBE ser igual al movimiento de la cámara
@export var mov: int = 90

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position.y -= mov * delta 
