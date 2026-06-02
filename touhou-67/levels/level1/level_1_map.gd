extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
var cam_velocity: float = 100


# Función para reiniciar nivel (Tecla "R")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
	
func _process(delta: float) -> void:
	pass
