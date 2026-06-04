extends Node2D

@onready var character_p: CharacterBody2D = $CharacterP
@onready var camera_2d: Camera2D = $Camera2D
@onready var retry_screen: Control = $CanvasLayer2/RetryScreen
@onready var enemy: CharacterBody2D = $Enemy
var cam_velocity: float = 100
@onready var victory_screen: Control = $CanvasLayer3/VictoryScreen


# Función para reiniciar nivel (Tecla "R")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()
		
func limpiar_balas() -> void:
	for bala in get_tree().get_nodes_in_group("balas"):
		bala.queue_free()

func _ready() -> void:
	retry_screen.hola.connect(limpiar_balas)
	
func _physics_process(delta: float) -> void:
	pass
	
func _process(delta: float) -> void:
	pass
