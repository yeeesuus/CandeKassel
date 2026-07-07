extends Area2D

# cantidad de movimiento de la plataforma hacia arriba
# DEBE ser igual al movimiento de la cámara
@export var mov: int = 90

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position.y -= mov * delta 

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damage_por_fondo"):
		body.damage_por_fondo()
